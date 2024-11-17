extends MarginContainer

func _ready() -> void:
	for i in range(Player.INVENTORY_SIZE):
		var inventory_slot = preload("res://ui/inventory/inventory_slot.tscn").instantiate()
		if i <= 4:
			inventory_slot.is_hotbar_slot = true
		inventory_slot.create_inventory_item.connect(create_inventory_item)
		inventory_slot.delete_inventory_item.connect(delete_inventory_item)
		inventory_slot.slot_id = i
		$GridContainer.add_child(inventory_slot)
		

func _physics_process(delta: float) -> void:
	if UI.showing_inventory_item:
		get_parent().get_node("InventoryItem").position = get_viewport().get_mouse_position() + Vector2(8.0, 8.0)

func create_inventory_item(item_node: Sprite2D) -> void:
	if not UI.showing_inventory_item:
		item_node.global_position = get_viewport().get_mouse_position() + Vector2(8.0, 8.0)
		item_node.z_index = 101
		get_parent().add_child(item_node)
		UI.showing_inventory_item = true
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		
func delete_inventory_item() -> void:
	UI.showing_inventory_item = false
	get_parent().get_node("InventoryItem").queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
