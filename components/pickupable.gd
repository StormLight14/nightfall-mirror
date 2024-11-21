extends Node

@export var item_id = "item"
@export var amount = 1
@export var is_shapeshifter = false

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	if is_shapeshifter:
		$Sprite2D.modulate = Color(0.7, 0.7, 0.7, 1)
