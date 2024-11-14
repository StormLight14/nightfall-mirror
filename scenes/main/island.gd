extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Grass.update_full_tileset()
	%Path.update_full_tileset()
	pass
