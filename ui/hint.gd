extends Control

@export var button = "E"

func _ready() -> void:
	$Label.text = Text.game_text[Settings.language]["pickup_hint"].replace("BUTTON", button)
