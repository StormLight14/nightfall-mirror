extends Control

func _ready() -> void:
	set_labels()
	Settings.language_changed.connect(set_labels)
	
func set_labels() -> void:
	%StartButton.text = Text.game_text[Settings.language]["start_button"]
	%SettingsButton.text = Text.game_text[Settings.language]["settings_button"]
	%QuitButton.text = Text.game_text[Settings.language]["quit_button"]

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main/island.tscn")
	Audio.play_sound("ui_click_1", 0.2)

func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/settings/settings.tscn")
	Audio.play_sound("ui_click_1", 0.2)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
