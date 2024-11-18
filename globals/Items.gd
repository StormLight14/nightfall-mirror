extends Node

var items := {
	"rock": {
		"id": "rock",
		"display_name": "Rock",
		"item_sprite": preload("res://scenes/objects/rocks/rock1.png"),
		"stack_size": 10,
		"crafting_ingredients": [null, 0]
	},
	"wood": {
		"id": "wood",
		"display_name": "Wood",
		"item_sprite": preload("res://scenes/objects/items/wood.png"),
		"stack_size": 10,
		"crafting_ingredients": [null, 0]
	},
}
