extends Node

var inventory := []

signal inventory_updated

func _ready():
	for _i in range(16):
		inventory.push_back(null)

# Function to add items to the inventory
func add_to_inventory(item_id: String, item_amount: int) -> void:
	for i in range(len(inventory)):
		if inventory[i] == null:
			# If an empty slot is found, try to add the item
			if Items.items.has(item_id):
				var item_data = Items.items[item_id]
				inventory[i] = [item_data, 0]  # Assign item data to the slot and set initial amount to 0
				_add_to_inventory_slot(i, item_amount)  # Add item amount to this slot
				inventory_updated.emit()
				return
			else:
				print("WARNING: Attempted to add invalid item to inventory.")
				return

		# Check if the item already exists in the inventory
		elif inventory[i][0].id == item_id:
			# If the item exists, try to add it to the current stack
			_add_to_inventory_slot(i, item_amount)
			inventory_updated.emit()
			return

	print("WARNING: No empty slot found to add the item.")
  
# Helper function to add the amount to the inventory slot
func _add_to_inventory_slot(slot_index: int, amount: int) -> void:
	var item_data = inventory[slot_index][0]
	var current_amount = inventory[slot_index][1]

	# Check if the item can be stacked
	if current_amount + amount <= item_data.stack_size:
		inventory[slot_index][1] += amount  # Add amount to current stack
	else:
		# Stack is full, add the remaining items to another slot
		var space_left = item_data.stack_size - current_amount
		inventory[slot_index][1] = item_data.stack_size  # Fill the current stack

		# If there are still items left, try to add them to the next slot
		var remaining_amount = amount - space_left
		
		# Instead of calling `add_to_inventory` recursively, handle the remaining amount
		# If there are no empty slots, we can't add the remaining items, so we print a warning
		var empty_slot_found = false
		for i in range(len(inventory)):
			if inventory[i] == null:
				inventory[i] = [item_data, remaining_amount]  # Add remaining items to new slot
				empty_slot_found = true
				inventory_updated.emit()
				break
		
		if not empty_slot_found:
			print("WARNING: No empty slot found for remaining items.")
