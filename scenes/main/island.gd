extends Node2D

var is_day = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Grass.update_full_tileset()
	%Path.update_full_tileset()
	daytime()
	%AnimationPlayer.speed_scale = 10 # for testing night
	%AnimationPlayer.play("turn_night")

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
		%DayTimer.start()
	elif anim_name == "turn_night":
		%NightTimer.start() # night ends when this timer finishes
		is_day = false

func _on_night_timer_timeout() -> void:
	is_day = true
	Player.nights_survived += 1
	Signals.night_ended.emit()
	%AnimationPlayer.play("turn_day")

func _on_day_timer_timeout() -> void:
	%AnimationPlayer.play("turn_night")
