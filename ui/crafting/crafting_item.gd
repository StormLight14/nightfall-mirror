extends Control

var item: Dictionary

func _ready() -> void:
	if item:
		%Item.texture = item.item_sprite
		if len(item.crafting_ingredients) >= 1:
			%Ingredient1.texture = Items.items[item.crafting_ingredients[0][0]].item_sprite
