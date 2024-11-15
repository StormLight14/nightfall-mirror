extends Control

@export var is_hotbar_slot = false
@export var slot_id = 0

func _ready():
	if is_hotbar_slot:
		$TextureRect.texture = preload("res://ui/inventory/hotbar_inventory_slot.png")
	update_slot_item()
	Player.inventory_updated.connect(update_slot_item)

func update_slot_item():
	print("received inventory update signal")
	if Player.inventory[slot_id]:
		$Sprite2D.texture = Player.inventory[slot_id][0].item_sprite
		$StackAmount.text = str(Player.inventory[slot_id][1])
	else:
		$Sprite2D.texture = null
		$StackAmount.text = ""
