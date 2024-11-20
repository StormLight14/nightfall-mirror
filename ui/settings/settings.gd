extends CenterContainer 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://menus/main/main_menu.tscn")

func _on_language_select_item_selected(index: int) -> void:
	var language := "EN"
	match index:
		0:
			language = "EN"
		1:
			language = "NL"
