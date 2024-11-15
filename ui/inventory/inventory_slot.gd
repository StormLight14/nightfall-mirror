extends Control

@export var is_hotbar_slot = false
@export var slot_id = 0

signal create_inventory_item(item_node: Sprite2D)

func _ready():
	if is_hotbar_slot:
		$TextureButton.texture_focused = preload("res://ui/inventory/hotbar_inventory_slot.png")
		$TextureButton.texture_hover = preload("res://ui/inventory/hotbar_inventory_slot.png")
		$TextureButton.texture_normal = preload("res://ui/inventory/hotbar_inventory_slot.png")
		$TextureButton.texture_pressed = preload("res://ui/inventory/hotbar_inventory_slot.png")
	update_slot_item()
	Player.inventory_updated.connect(update_slot_item)
	
func _physics_process(delta: float) -> void:
	if get_node_or_null("InventoryItem"):
		get_node("InventoryItem").global_position = get_viewport().get_mouse_position()

func update_slot_item():
	#print("received inventory update signal")
	if Player.inventory[slot_id]:
		%SlotSprite.texture = Player.inventory[slot_id][0].item_sprite
		%StackAmount.text = str(Player.inventory[slot_id][1])
	else:
		%SlotSprite.texture = null
		%StackAmount.text = ""

func _on_texture_button_pressed() -> void:
	if Player.inventory[slot_id]:
		var inventory_item = preload("res://ui/inventory/inventory_item.tscn").instantiate()
		inventory_item.texture = Player.inventory[slot_id][0].item_sprite
		create_inventory_item.emit(inventory_item)
