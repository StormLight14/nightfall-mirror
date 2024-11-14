extends CharacterBody2D

@export var SPEED := 3000.0

@onready var night_light = %NightLight

var pickupable_object = null

func _physics_process(delta: float) -> void:
	movement(delta)
	
func movement(delta: float) -> void:
	var input_vector := Input.get_vector("left", "right", "up", "down")
	var direction := input_vector.normalized()
	velocity = direction * SPEED * delta
	move_and_slide()

func _on_pickup_area_area_entered(area: Area2D) -> void:
	var hint := area.get_parent().get_node("Hint")
	if hint && Settings.show_hints:
		hint.visible = true
		
	pickupable_object = area.get_parent()

func _on_pickup_area_area_exited(area: Area2D) -> void:
	var hint := area.get_parent().get_node("Hint")
	if hint:
		hint.visible = false
		
	pickupable_object = null
