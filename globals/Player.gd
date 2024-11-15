extends Node

var inventory := []

func _ready():
	for _i in range(16):
		inventory.push_back(null)

func add_to_inventory(item_id: String) -> void:
	for i in range(len(inventory)):
		if inventory[i] == null:
			if Items.items.has(item_id):
				inventory[i] = Items.items[item_id]  # assign item slot to have item dictionary
			else:
				print("WARNING: Attempted to add invalid item to inventory.")
			print(inventory)
			return
