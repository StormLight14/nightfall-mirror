extends Area2D

var block_spawn := false

func _on_body_entered(_body: Node2D) -> void:
	block_spawn = true

func _on_body_exited(_body: Node2D) -> void:
	block_spawn = false
