extends Control

func _ready() -> void:
	Signals.inventory_updated.connect(update_crafting_list)
	%CraftButton.visible = false
	update_crafting_list()
	
func _process(_delta) -> void:
	var crafting_item_selected = false
	if %CraftButton.visible == true:
		%CraftButton.visible = false
	for crafting_item in %CraftingItems.get_children():
		if crafting_item.selected:
			%CraftButton.visible = true

func update_crafting_list() -> void:
	clear_crafting_list()
	
	var available_items = Items.items
	
	for item_key in available_items.keys():
		var item = available_items[item_key]
		
		if item.crafting_ingredients:
			if can_craft(item.crafting_ingredients):
				add_crafting_option(item)

func can_craft(crafting_ingredients: Array) -> bool:
	for ingredient in crafting_ingredients:
		var ingredient_id = ingredient[0]
		var required_amount = ingredient[1]
		var inventory_amount = get_inventory_amount(ingredient_id)
		if inventory_amount < required_amount:
			return false
	return true

func get_inventory_amount(item_id: String) -> int:
	var count = 0
	for slot in Player.inventory:
		if slot and slot[0].id == item_id:
			count += slot[1]
	return count

func add_crafting_option(item: Dictionary) -> void:
	var crafting_item = preload("res://ui/crafting/crafting_item.tscn").instantiate()
	crafting_item.item = item
	%CraftingItems.add_child(crafting_item)
	%CraftButton.visible = true

func clear_crafting_list() -> void:
	for child in %CraftingItems.get_children():
		child.queue_free()

func _on_craft_button_pressed() -> void:
	print("test")
	if Player.selected_crafting_item_id == null:
		print("No crafting item selected.")
		return
	
	# get selected crafting item's data
	var crafted_item_data = Items.items.get(Player.selected_crafting_item_id, null)
	if crafted_item_data == null:
		print("Invalid crafted item selected.")
		return
	
	# check player can craft the item
	if not can_craft(crafted_item_data.crafting_ingredients):
		print("Not enough materials to craft this item.")
		return

	# remove materials player's inventory
	for ingredient in crafted_item_data.crafting_ingredients:
		var ingredient_id = ingredient[0]
		var amount_to_remove = ingredient[1]
		Player.remove_from_inventory(ingredient_id, amount_to_remove)

	Player.add_to_inventory(crafted_item_data.id, 1)
	print("Crafted:", crafted_item_data.display_name)

	update_crafting_list()
