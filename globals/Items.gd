extends Node

var items := {
	"rock": {
		"id": "rock",
		"display_name": "Rock",
		"item_sprite": preload("res://scenes/objects/rocks/rock1.png"),
		"stack_size": 10,
		"crafting_ingredients": null
	},
	"twig": {
		"id": "twig",
		"display_name": "Twig",
		"item_sprite": preload("res://scenes/objects/items/twig.png"),
		"stack_size": 10,
		"crafting_ingredients": null
	},
	"wood": {
		"id": "wood",
		"display_name": "Wood",
		"item_sprite": preload("res://scenes/objects/items/wood.png"),
		"stack_size": 10,
		"crafting_ingredients": null
	},
	"rock_on_stick": {
		"id": "rock_on_stick",
		"display_name": "Rock on Stick",
		"item_sprite": preload("res://scenes/objects/items/rock_on_stick.png"),
		"stack_size": 1,
		"crafting_ingredients": [["rock", 1], ["twig", 1]]
	}
}
