extends Node

@export var item_id = "item"
@export var amount = 1
@export var is_shapeshifter = false

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	if is_shapeshifter:
		$Sprite2D.modulate = Color(1, 1, 1, 0.725)
