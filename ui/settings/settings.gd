extends CenterContainer

func _ready():
	Signals.language_changed.connect(set_labels)
	set_labels()
	%LanguageSelect.selected = Settings.language
	
func set_labels():
	%LanguageLabel.text = Text.game_text[Settings.language]["settings_language"] + ": "
	%ShowHintsLabel.text = Text.game_text[Settings.language]["settings_show_hints"] + ": "

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://ui/menus/main/main_menu.tscn")

func _on_language_select_item_selected(index: int) -> void:
	Settings.language = index
	Signals.language_changed.emit()

func _on_show_hints_check_toggled(toggled_on: bool) -> void:
	Settings.show_hints = toggled_on
