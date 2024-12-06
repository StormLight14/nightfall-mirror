extends CharacterBody2D

@export var SPEED := 3000.0

@onready var night_light = %NightLight

var active_pickup_areas := []
var pickupable_object = null
var pickupable_area = null
var pickupable_item_id = null

var speed_scale = 1.0
var brightness_scale = 1.0

func _ready() -> void:
	if not Settings.show_hints:
		%GlobalHintLabel.visible = false
	$AnimatedSprite2D.play("static_down")
	Signals.show_gamble_ui.connect(show_gamble_ui)
	Signals.set_speed_scale.connect(set_speed_scale)
	Signals.set_brightness_scale.connect(set_brightness_scale)

func _physics_process(delta: float) -> void:
	movement(delta)
	movement_hint()
	interactions()
	animations()
	handle_ui_inputs()
	hotbar_selection()
	
func movement_hint():
	if velocity != Vector2.ZERO && %ClearHintTimer.is_stopped() == true:
		%ClearHintTimer.start()

func animations() -> void:
	if Input.is_action_pressed("down"):
		$AnimatedSprite2D.play("static_down")
	elif Input.is_action_pressed("up"):
		$AnimatedSprite2D.play("static_up")
	elif Input.is_action_pressed("left"):
		$AnimatedSprite2D.play("static_left")
	elif Input.is_action_pressed("right"):
		$AnimatedSprite2D.play("static_right")

func movement(delta: float) -> void:
	if not %GoMenuTimer.is_stopped():
		return

	var input_vector := Input.get_vector("left", "right", "up", "down")
	var direction := input_vector.normalized()
	velocity = direction * SPEED * delta * speed_scale
	move_and_slide()

func handle_ui_inputs() -> void:
	if Input.is_action_just_pressed("inventory"):
		%Inventory.visible = !%Inventory.visible
		%Crafting.visible = !%Crafting.visible
		%Hotbar.visible = !%Inventory.visible

func interactions() -> void:
	if Input.is_action_just_pressed("interact"):
		if pickupable_object:
			if not pickupable_object.get_node("Pickupable").is_shapeshifter:
				Player.add_to_inventory(pickupable_object.get_node("Pickupable").item_id, pickupable_object.get_node("Pickupable").amount)
			else:
				for island in get_tree().get_nodes_in_group("Island"):
					var shapeshifter = preload("res://entities/shapeshifter/shapeshifter.tscn").instantiate()
					shapeshifter.global_position = pickupable_object.global_position
					island.add_child(shapeshifter)
			Audio.play_sound("pickup", 0.75, -10.0)
			pickupable_object.queue_free()

func hotbar_selection() -> void:
	if Input.is_action_just_pressed("hotbar1"):
		Player.selected_hotbar_slot_id = 0
		Signals.changed_hotbar_selection.emit()
	elif Input.is_action_just_pressed("hotbar2"):
		Player.selected_hotbar_slot_id = 1
		Signals.changed_hotbar_selection.emit()
	elif Input.is_action_just_pressed("hotbar3"):
		Player.selected_hotbar_slot_id = 2
		Signals.changed_hotbar_selection.emit()
	elif Input.is_action_just_pressed("hotbar4"):
		Player.selected_hotbar_slot_id = 3
		Signals.changed_hotbar_selection.emit()
	elif Input.is_action_just_pressed("hotbar5"):
		Player.selected_hotbar_slot_id = 4
		Signals.changed_hotbar_selection.emit()
	elif Input.is_action_just_pressed("hotbar_down") && Player.selected_hotbar_slot_id > 0:
		Player.selected_hotbar_slot_id -= 1
		Signals.changed_hotbar_selection.emit()
	elif Input.is_action_just_pressed("hotbar_up") && Player.selected_hotbar_slot_id < 4:
		Player.selected_hotbar_slot_id += 1
		Signals.changed_hotbar_selection.emit()

func set_speed_scale(speed: float) -> void:
	speed_scale = speed
	
func set_brightness_scale(brightness: float) -> void:
	brightness_scale = brightness

func _on_pickup_area_area_entered(area: Area2D) -> void:
	var hint := area.get_node("Hint")
	if hint and Settings.show_hints:
		hint.visible = true  # show the hint for this area
	
	# hide the hint for the previously picked-up object
	if pickupable_area:
		pickupable_area.get_node("Hint").visible = false

	# update the currently picked-up object and item ID
	pickupable_object = area.get_parent()
	pickupable_area = area
	pickupable_item_id = area.item_id

	# add the new area to the active list
	if area not in active_pickup_areas:
		active_pickup_areas.append(area)

func _on_pickup_area_area_exited(area: Area2D) -> void:
	var hint := area.get_node("Hint")
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
		pickupable_area = last_area
		pickupable_item_id = last_area.item_id
	else:
		# if no active areas, reset the pickupable object and item ID
		pickupable_object = null
		pickupable_item_id = null
		pickupable_area = null

func _on_hurtbox_area_area_entered(_area: Area2D) -> void:
	if %GoMenuTimer.is_stopped() == true:
		# player dies
		Fade.play("player_died")
		%GoMenuTimer.start()

func _on_go_menu_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://ui/menus/main/main_menu.tscn")

func show_gamble_ui() -> void:
	if not %Inventory.visible:
		%GambleUI.visible()

func _on_clear_hint_timer_timeout() -> void:
	%GlobalHintLabel.text = ""
