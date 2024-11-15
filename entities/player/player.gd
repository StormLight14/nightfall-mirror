extends CharacterBody2D

@export var SPEED := 3000.0

@onready var night_light = %NightLight

var active_pickup_areas := []
var pickupable_object = null
var pickupable_item_id = null

func _physics_process(delta: float) -> void:
	movement(delta)
	interactions()
	handle_ui_inputs()
	
func movement(delta: float) -> void:
	var input_vector := Input.get_vector("left", "right", "up", "down")
	var direction := input_vector.normalized()
	velocity = direction * SPEED * delta
	move_and_slide()
	
func handle_ui_inputs() -> void:
	if Input.is_action_just_pressed("inventory"):
		%Inventory.visible = !%Inventory.visible
		%Hotbar.visible = !%Inventory.visible
	
func interactions() -> void:
	if Input.is_action_just_pressed("interact"):
		if pickupable_object && pickupable_item_id:
			pickupable_object.queue_free()
			Player.add_to_inventory(pickupable_item_id, 10) # temp 10 for testing
		else:
			print("WARNING: attempted to pick up null object")

func _on_pickup_area_area_entered(area: Area2D) -> void:
	var hint := area.get_parent().get_node("Hint")
	if hint and Settings.show_hints:
		hint.visible = true  # Show the hint for this area
	
	# hide the hint for the previously picked-up object
	if pickupable_object:
		pickupable_object.get_node("Hint").visible = false

	# update the currently picked-up object and item ID
	pickupable_object = area.get_parent()
	pickupable_item_id = area.item_id

	# add the new area to the active list
	if area not in active_pickup_areas:
		active_pickup_areas.append(area)

func _on_pickup_area_area_exited(area: Area2D) -> void:
	var hint := area.get_parent().get_node("Hint")
	if hint:
		hint.visible = false
	
	active_pickup_areas.erase(area)
	
	# if there are still active pickup areas, show the hint for the last one
	if active_pickup_areas.size() > 0:
		var last_area = active_pickup_areas[active_pickup_areas.size() - 1]
		var last_hint = last_area.get_parent().get_node("Hint")
		if last_hint and Settings.show_hints:
			last_hint.visible = true
		
		# update the pickupable object and item ID to match the last active area
		pickupable_object = last_area.get_parent()
		pickupable_item_id = last_area.item_id
	else:
		# if no active areas, reset the pickupable object and item ID
		pickupable_object = null
		pickupable_item_id = null
