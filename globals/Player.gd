extends Node

const INVENTORY_SIZE = 20

var inventory := []
var selected_hotbar_slot_id = 0 # 0, 1, 2, 3
var selected_crafting_item_id = null

var nights_survived := 0


func _ready():
	for _i in range(Player.INVENTORY_SIZE):
		inventory.push_back(null)

func add_to_inventory(item_id: String, item_amount: int) -> void:
	# first, try to add to an existing non-full stack
	for i in range(len(inventory)):
		if inventory[i] != null and inventory[i][0].id == item_id:
			# check if the stack can accommodate more items
			var item_data = inventory[i][0]
			var current_amount = inventory[i][1]
			if current_amount < item_data.stack_size:
				_add_to_inventory_slot(i, item_amount)
				Signals.inventory_updated.emit()
				return

	# if no non-full stack was found, add to the first empty slot
	for i in range(len(inventory)):
		if inventory[i] == null:
			if Items.items.has(item_id):
				var item_data = Items.items[item_id]
				inventory[i] = [item_data, 0]  # assign item data to the slot with initial amount 0
				_add_to_inventory_slot(i, item_amount)
				Signals.inventory_updated.emit()
				return
			else:
				print("WARNING: attempted to add invalid item to inventory.")
				return

	print("WARNING: no space available in inventory.")

func _add_to_inventory_slot(slot_index: int, amount: int) -> void:
	var item_data = inventory[slot_index][0]
	var current_amount = inventory[slot_index][1]

	# check if the item can be stacked
	if current_amount + amount <= item_data.stack_size:
		inventory[slot_index][1] += amount  # Add amount to current stack
	else:
		# stack is full, add the remaining items to another slot
		var space_left = item_data.stack_size - current_amount
		inventory[slot_index][1] = item_data.stack_size  # Fill the current stack

		# if there are still items left, try to add them to the next slot
		var remaining_amount = amount - space_left
		
		# instead of calling `add_to_inventory` recursively, handle the remaining amount
		var empty_slot_found = false
		for i in range(len(inventory)):
			if inventory[i] == null:
				inventory[i] = [item_data, remaining_amount]  # Add remaining items to new slot
				empty_slot_found = true
				Signals.inventory_updated.emit()
				break
		
		if not empty_slot_found:
			print("WARNING: No empty slot found for remaining items.")

func swap_slot_items(slot_1, slot_2) -> void:
	if inventory[slot_1]:
		var temp_item_1 = inventory[slot_1]
		inventory[slot_1] = inventory[slot_2]
		inventory[slot_2] = temp_item_1
		Signals.inventory_updated.emit()
