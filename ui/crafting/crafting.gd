extends Control

func _ready() -> void:
	Signals.inventory_updated.connect(update_crafting_list)
	update_crafting_list()

func update_crafting_list() -> void:
	clear_crafting_list()
	
	# Load all items
	var available_items = Items.items
	
	# Iterate through items and find crafting options
	for item_key in available_items.keys():
		var item = available_items[item_key]
		
		# Check if the item has crafting ingredients
		if item.crafting_ingredients:
			# Check if the player has the necessary ingredients
			if can_craft(item.crafting_ingredients):
				print("Craftable: " + item.display_name)
				add_crafting_option(item)

func can_craft(crafting_ingredients: Array) -> bool:
	# Iterate through required ingredients and check inventory
	for ingredient in crafting_ingredients:
		var ingredient_id = ingredient[0]
		var required_amount = ingredient[1]
		var inventory_amount = get_inventory_amount(ingredient_id)
		if inventory_amount < required_amount:
			return false
	return true

func get_inventory_amount(item_id: String) -> int:
	# Count the number of items in the player's inventory
	var count = 0
	for slot in Player.inventory:
		if slot and slot[0].id == item_id:
			count += slot[1]
	return count

func add_crafting_option(item: Dictionary) -> void:
	# Add the crafting option to the UI (replace with actual UI logic)
	# For now, just printing to console
	var crafting_item = preload("res://ui/crafting/crafting_item.tscn").instantiate()
	crafting_item.item = item
	%CraftingItems.add_child(crafting_item)

func clear_crafting_list() -> void:
	# Clear the crafting list UI (replace with actual UI logic)
	print("Clearing crafting list")
