extends CharacterBody2D

func _ready() -> void:
	Signals.night_ended.connect(despawn)

func _physics_process(delta: float) -> void:
	for player in get_tree().get_nodes_in_group("Player"):
		$Sprite2D.flip_h = player.global_position < global_position

func despawn() -> void:
	queue_free()
