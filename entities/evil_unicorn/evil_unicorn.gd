extends CharacterBody2D

func _physics_process(delta: float) -> void:
	for player in get_tree().get_nodes_in_group("Player"):
		$Sprite2D.flip_h = player.global_position < global_position
