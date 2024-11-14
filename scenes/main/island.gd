extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Grass.update_full_tileset()
	%Path.update_full_tileset()
	daytime()
	pass
	
func _process(_delta) -> void:
	if Input.is_action_just_pressed("turn_day"):
		daytime()
	elif Input.is_action_just_pressed("turn_night"):
		nighttime()
		
	if Input.is_action_pressed("rotate_sun"):
		%Sun.rotation_degrees += 0.5

func daytime() -> void:
	%Sun.energy = 0.5
	%Player.night_light.visible = false
	%LevelLighting.color = Color(0.5, 0.5, 0.5, 1.0)

func nighttime() -> void:
	%Sun.energy = 0.0
	%Player.night_light.visible = true
	%LevelLighting.color = Color(0.0, 0.0, 0.0, 1.0)
