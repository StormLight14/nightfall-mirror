extends Node

var inventory := [
	[null, null, null, null, null],
	[null, null, null, null, null],
	[null, null, null, null, null]
]

func add_to_inventory(item_id: String) -> void:
	for row in inventory:
		for i in range(len(row)):
			if row[i] == null:
				if Items.items.has(item_id):
					row[i] = Items.items[item_id]  # assign item slot to have item dictionary
				else:
					print("WARNING: Attempted to add invalid item to inventory.")
				print(inventory)
				return
