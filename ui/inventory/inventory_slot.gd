extends Control

@export var is_hotbar_slot = false
@export var slot_id = 0

signal create_inventory_item(item_node: Sprite2D)
signal delete_inventory_item

func _ready():
	update_slot()
	Player.inventory_updated.connect(update_slot)
	Player.changed_hotbar_selection.connect(update_slot)

func _physics_process(delta: float) -> void:
	if get_node_or_null("InventoryItem"):
		get_node("InventoryItem").global_position = get_viewport().get_mouse_position()

func update_slot():
	#print("received inventory update signal")
	if Player.inventory[slot_id]:
		%SlotSprite.texture = Player.inventory[slot_id][0].item_sprite
		%StackAmount.text = str(Player.inventory[slot_id][1]) + "/" + str(Player.inventory[slot_id][0].stack_size)
	else:
		%SlotSprite.texture = null
		%StackAmount.text = ""
		
	if is_hotbar_slot:
		%InputLabel.visible = true
		%InputLabel.text = str(slot_id + 1)
		var slot_texture: Texture2D
		if Player.selected_hotbar_slot_id == slot_id:
			slot_texture = preload("res://ui/inventory/hotbar_inventory_slot_selected.png")
		else:
			slot_texture = preload("res://ui/inventory/hotbar_inventory_slot.png")
		$TextureButton.texture_focused = slot_texture
		$TextureButton.texture_hover = slot_texture
		$TextureButton.texture_normal = slot_texture
		$TextureButton.texture_pressed = slot_texture

func _on_texture_button_pressed() -> void:
	if Player.inventory[slot_id] && not UI.showing_inventory_item:
		var inventory_item = preload("res://ui/inventory/inventory_item.tscn").instantiate()
		inventory_item.texture = Player.inventory[slot_id][0].item_sprite
		UI.inventory_item_original_slot = slot_id
		create_inventory_item.emit(inventory_item)
	elif slot_id != UI.inventory_item_original_slot && Player.inventory[UI.inventory_item_original_slot]:
		Player.swap_slot_items(UI.inventory_item_original_slot, slot_id)
		delete_inventory_item.emit()
