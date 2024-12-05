extends CharacterBody2D

var can_interact := false

func _ready() -> void:
	Signals.night_ended.connect(start_despawn)

func _physics_process(_delta: float) -> void:
	for player in get_tree().get_nodes_in_group("Player"):
		$Sprite2D.flip_h = player.global_position < global_position

	if Input.is_action_just_pressed("interact") && can_interact:
		$Dialogue.text = "..."
		start_despawn()

func start_despawn() -> void:
	$AnimationPlayer.play("despawn")

func _on_interact_area_body_entered(_body: Node2D) -> void:
	$Dialogue.text = "Press E to play my game."
	can_interact = true

func _on_interact_area_body_exited(_body: Node2D) -> void:
	$Dialogue.text = ""
	can_interact = false

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$DespawnTimer.start()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "despawn":
		Signals.show_gamble_ui.emit()
		queue_free()
