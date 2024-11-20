extends MarginContainer

func _ready():
	%LanguageSelect.selected = Settings.language

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://menus/main/main_menu.tscn")

func _on_language_select_item_selected(index: int) -> void:
	Settings.language = index
	Settings.language_changed.emit()
