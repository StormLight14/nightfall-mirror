extends Node

var inventory := [
	[null, null, null, null, null],
	[null, null, null, null, null],
	[null, null, null, null, null]
]

func add_to_inventory(item_id: String) -> void:
	for row in inventory:
		for item_slot in row:
			if item_slot == null:
				if Items.items[item_id]:
					item_slot = Items.items[item_id]
				else:
					print("WARNING: Attempted to add invalid item to inventory.")
				print(inventory)
				return
