extends MarginContainer

func _ready():
	Signals.night_ended.connect(update_label)
	Signals.language_changed.connect(update_label)
	update_label()
	
func update_label():
	if Settings.language == 1:
		$Label.text = str(Player.nights_survived) + " night" + ("s" if Player.nights_survived != 1 else "") + " survived"
	else:
		$Label.text = Text.game_text[Settings.language]["nights_survived"].replace("NUMBER", str(Player.nights_survived))
