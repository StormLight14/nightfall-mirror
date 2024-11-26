shader_type canvas_item;
render_mode unshaded;

uniform vec4 color : source_color;
uniform float angle : hint_range(-360,360);  // Allow for negative angles
uniform float max_dist : hint_range(0,1000) = 100;
uniform sampler2D gradientTexture;

vec4 get_gradient_color(float position) {
    return texture(gradientTexture, vec2(position, 0.5));
}

void fragment() {
    // Normalize the angle to radians
    float ang_rad = angle * 3.1416 / 180.0;
    
    // Adjust the angle so that 0 degrees points right, and angles follow the expected coordinate system
    ang_rad -= 3.1416 / 2.0;  // This makes 0 degrees point to the right (positive x-axis)
    
    // Calculate the direction using cosine and sine for x and y components
    vec2 dir = vec2(cos(ang_rad), sin(ang_rad));  // cos for x, sin for y
    
    // Sample the SDF texture and compute the raycast
    vec2 at = screen_uv_to_sdf(SCREEN_UV);
    float accum = 0.0;
    while(accum < max_dist) {
        float d = texture_sdf(at);
        accum += d;
        if (d < 0.01) {
            break;
        }
        at += d * dir;
    }
	

    // Compute the alpha based on the accumulated distance
    float alpha = 1.0 - min(1.0, accum / max_dist);

    // The gradient controls the falloff of the shadow
    alpha = get_gradient_color(alpha).r;

    // Set the final color
    COLOR = vec4(color.rgb, alpha * color.a);
}
