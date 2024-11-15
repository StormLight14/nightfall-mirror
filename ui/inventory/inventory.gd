extends CenterContainer

func _ready() -> void:
	for inventory_slot in get_tree().get_nodes_in_group("InventorySlot"):
		inventory_slot.create_inventory_item.connect(create_inventory_item)
		inventory_slot.delete_inventory_item.connect(delete_inventory_item)

func _physics_process(delta: float) -> void:
	if Player.showing_inventory_item:
		get_node("InventoryItem").position = get_viewport().get_mouse_position() + Vector2(8.0, 8.0)

func create_inventory_item(item_node: Sprite2D) -> void:
	if not Player.showing_inventory_item:
		add_child(item_node)
		Player.showing_inventory_item = true
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func delete_inventory_item() -> void:
	Player.showing_inventory_item = false
	get_node("InventoryItem").queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
