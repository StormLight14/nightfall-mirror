extends Control

@export var is_hotbar_slot = false
@export var slot_id = 0

func _ready():
	if is_hotbar_slot:
		$TextureRect.texture = preload("res://ui/inventory/hotbar_inventory_slot.png")
	update_slot_item()
	Player.inventory_updated.connect(update_slot_item)

func update_slot_item():
	if Player.inventory[slot_id]:
		$Sprite2D.texture = Player.inventory[slot_id].item_sprite
