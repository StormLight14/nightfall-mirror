extends AudioStreamPlayer

func play_sound(sound_name: String, at: float = 0.0) -> void:
	match sound_name:
		"ui_click_1":
			stream = load("res://ui/sounds/ui_click_1.mp3")

	if stream:
		play(at)
