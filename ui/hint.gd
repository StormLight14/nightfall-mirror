extends Control

@export var text = "Press BUTTON to pick up."

func _ready() -> void:
	$Label.text = text
