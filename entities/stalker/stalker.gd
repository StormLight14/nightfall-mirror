extends CharacterBody2D

enum {
	STILL,
	FOLLOWING,
	ATTACKING
}

var state := STILL
var player_in_follow_area := false

func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_follow_area_area_entered(area: Area2D) -> void:
	player_in_follow_area = true

func _on_follow_area_area_exited(area: Area2D) -> void:
	player_in_follow_area = false
