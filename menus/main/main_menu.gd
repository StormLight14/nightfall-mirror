extends Control

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main/island.tscn")
	Audio.play_sound("ui_click_1", 0.2)

func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/settings/settings.tscn")
	Audio.play_sound("ui_click_1", 0.2)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
