extends AudioStreamPlayer

func play_sound(sound_name: String, at: float = 0.0, audio_scale: float = 1.0) -> void:
	match sound_name:
		"ui_click_1":
			stream = load("res://sounds/ui_click_1.mp3")
		"pickup":
			print("pickup")
			stream = load("res://sounds/pickup.mp3")
	if stream:
		play(at)
