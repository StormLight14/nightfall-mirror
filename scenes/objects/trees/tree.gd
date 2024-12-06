extends StaticBody2D

var mouse_in_area = false
var player_in_area = false

func _ready():
	var pine_type = randi_range(1, 2)

	if pine_type == 2:
		%Pine1Shape.disabled = true
		$Pine1Sprite.visible = false
		$Pine2Sprite.visible = true
	else:
		%Pine2Shape.disabled = true
		$Pine1Sprite.visible = true
		$Pine2Sprite.visible = false
	
	var rand_scale := randf_range(0.9, 1.1)
	$Pine1Sprite.scale *= rand_scale
	$Pine2Sprite.scale *= rand_scale
	$Pine1Shape.scale *= rand_scale
	$Pine2Shape.scale *= rand_scale
	
func update_mouse():
	if mouse_in_area:
		Input.set_custom_mouse_cursor(preload("res://ui/hit_cursor.png"))
	else:
		Input.set_custom_mouse_cursor(preload("res://ui/cursor.png"))

func _on_mouse_area_mouse_entered() -> void:
	mouse_in_area = true
	update_mouse()

func _on_mouse_area_mouse_exited() -> void:
	mouse_in_area = false
	update_mouse()
