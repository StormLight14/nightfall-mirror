extends Control

@export var is_hotbar_slot = false

func _ready():
	if is_hotbar_slot:
		$TextureRect.texture = preload("res://ui/inventory/hotbar_inventory_slot.png")
