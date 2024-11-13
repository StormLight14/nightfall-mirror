extends CharacterBody2D

const SPEED := 2500.0

func _physics_process(delta: float) -> void:
	var h_dir := Input.get_axis("left", "right")
	var v_dir := Input.get_axis("up", "down")
	var direction := Vector2(h_dir, v_dir).normalized()
	velocity = direction * SPEED * delta
	move_and_slide()
