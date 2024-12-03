extends Node2D

var is_day = true

func _ready() -> void:
	%StartRainTimer.start()
	daytime()
	%AnimationPlayer.speed_scale = 15 # for testing night cycle
	_on_day_timer_timeout() # to turn night instantly

func _process(_delta) -> void:
	if Input.is_action_just_pressed("turn_day"):
		daytime()
	elif Input.is_action_just_pressed("turn_night"):
		nighttime()

func handle_creature_spawns() -> void:
	var spawn_points: Array[Area2D] = []
	for spawn_point in get_tree().get_nodes_in_group("StalkerSpawnPoint"):
		if not spawn_point.block_spawn:
			spawn_points.push_back(spawn_point)
	
	if len(spawn_points):
		var creature_location := spawn_points[randi_range(0, len(spawn_points) - 1)].global_position
		var stalker := preload("res://entities/stalker/stalker.tscn").instantiate()
		stalker.global_position = creature_location
		$Objects.add_child(stalker)

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
		Signals.night_started.emit()
		handle_creature_spawns()

func _on_night_timer_timeout() -> void:
	is_day = true
	Player.nights_survived += 1
	Signals.night_ended.emit()
	%AnimationPlayer.play("turn_day")
	Signals.turning_day.emit(%AnimationPlayer.current_animation_length / %AnimationPlayer.speed_scale)

func _on_day_timer_timeout() -> void:
	%AnimationPlayer.play("turn_night")
	Signals.turning_night.emit(%AnimationPlayer.current_animation_length / %AnimationPlayer.speed_scale)

func _on_start_rain_timer_timeout() -> void:
	if randi_range(0, 1) == 1:
		%Rain.visible = true

func _on_stop_rain_timer_timeout() -> void:
	%Rain.visible = false
