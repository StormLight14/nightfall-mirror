extends StaticBody2D

func _ready():
	var pine_type = randi_range(1, 2)
	$Sprite2D.texture = load("res://scenes/objects/trees/pine" + str(pine_type) + ".png")
	if pine_type == 2:
		$Sprite2D.scale *= 1.5
