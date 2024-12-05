extends Control

var result = null # slow, fast, blind, stalker, nothing

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	modulate = Color(1, 1, 1, 0)

func visible() -> void:
	#var result = ["slow", "fast", "stalker", "blind"].pick_random()
	var result = "slow"
	match result:
		"slow":
			%Label.text = "you have become weaker..."
		"fast":
			%Label.text = "you feel a burst of energy..."
		"stalker":
			%Label.text = "there is a new presence here..."
		"blind":
			%Label.text = "your vision has decreased..."
	
	animation_player.play("visible")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "visible":
		animation_player.play("invisible")
	
	match result:
		"slow":
			Player.speed_scale -= 0.15
		"fast":
			Player.speed_scale -= 0.1
		"stalker":
			Signals.spawn_stalker.emit()
		"blind":
			Signals.blind_player.emit()
