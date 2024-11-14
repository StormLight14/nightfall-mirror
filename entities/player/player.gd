extends CharacterBody2D

@export var SPEED := 3000.0

@onready var night_light = %NightLight

func _physics_process(delta: float) -> void:
	var input_vector := Input.get_vector("left", "right", "up", "down")
	var direction := input_vector.normalized()
	velocity = direction * SPEED * delta
	move_and_slide()

func _on_pickup_area_area_entered(area: Area2D) -> void:
	print("pickup area entered")
	area.get_parent().get_node("Hint").visible = true
