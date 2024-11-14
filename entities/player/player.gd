extends CharacterBody2D

@export var SPEED := 3000.0

@onready var night_light = %NightLight

var pickupable_object = null
var pickupable_item_id = null

func _physics_process(delta: float) -> void:
	movement(delta)
	interactions()
	
func movement(delta: float) -> void:
	var input_vector := Input.get_vector("left", "right", "up", "down")
	var direction := input_vector.normalized()
	velocity = direction * SPEED * delta
	move_and_slide()
	
func interactions() -> void:
	if Input.is_action_just_pressed("interact"):
		if pickupable_object && pickupable_item_id:
			pickupable_object.queue_free()
			Player.add_to_inventory(pickupable_item_id)
		else:
			print("WARNING: attempted to pick up null object")

func _on_pickup_area_area_entered(area: Area2D) -> void:
	var hint := area.get_parent().get_node("Hint")
	if hint && Settings.show_hints:
		hint.visible = true
		
	pickupable_object = area.get_parent()
	pickupable_item_id = area.item_id

func _on_pickup_area_area_exited(area: Area2D) -> void:
	var hint := area.get_parent().get_node("Hint")
	if hint:
		hint.visible = false
		
	pickupable_object = null
	pickupable_item_id = null
