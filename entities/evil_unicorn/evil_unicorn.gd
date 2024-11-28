extends CharacterBody2D

func _ready() -> void:
	Signals.night_ended.connect(despawn)

func _physics_process(delta: float) -> void:
	for player in get_tree().get_nodes_in_group("Player"):
		$Sprite2D.flip_h = player.global_position < global_position

func despawn() -> void:
	queue_free()

func _on_interact_area_body_entered(body: Node2D) -> void:
	$Dialogue.text = "Press E to play my game."

func _on_interact_area_body_exited(body: Node2D) -> void:
	$Dialogue.text = ""

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$DespawnTimer.start()
