extends Node2D

var is_day = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Grass.update_full_tileset()
	%Path.update_full_tileset()
	daytime()
	%AnimationPlayer.speed_scale = 15
	%AnimationPlayer.play("turn_night")
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
	%LevelLighting.color = Color(0.5, 0.5, 0.5, 1.0)

func nighttime() -> void:
	%Sun.energy = 0.0
	%LevelLighting.color = Color(0.0, 0.0, 0.0, 1.0)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "turn_day":
		%DaylightCycleTimer.start()
		is_day = true
	elif anim_name == "turn_night":
		%DaylightCycleTimer.start()

func _on_daylight_cycle_timer_timeout() -> void:
	if is_day:
		%AnimationPlayer.play("turn_night")
	else:
		%AnimationPlayer.play("turn_day")
	
