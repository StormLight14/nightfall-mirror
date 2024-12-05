extends AudioStreamPlayer

func play_sound(sound_name: String, at: float = 0.0, decibel_offset: float = 0.0) -> void:
	match sound_name:
		"spooky1":
			stream = load("res://sounds/sfx/spooky1.wav")
		"ui_click_1":
			stream = load("res://sounds/sfx/ui_click_1.mp3")
		"pickup":
			stream = load("res://sounds/sfx/pickup.mp3")
	volume_db = decibel_offset
	if stream:
		play(at)
