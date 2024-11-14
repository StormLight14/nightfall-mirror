extends StaticBody2D

var textures := [
	preload("res://scenes/objects/rocks/rock1.png"),
	preload("res://scenes/objects/rocks/rock2.png"),
]

func _ready() -> void:
	var variation = randi_range(0, 1)  # Randomly pick a variation (0, 1, or 2)
	$Sprite2D.texture = textures[variation]
