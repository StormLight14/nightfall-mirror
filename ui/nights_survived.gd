extends MarginContainer

func _ready():
	Player.night_ended.connect(update_label)
	update_label()
	
func update_label():
	$Label.text = str(Player.nights_survived) + " night" + ("s" if Player.nights_survived != 1 else "") + " survived"
