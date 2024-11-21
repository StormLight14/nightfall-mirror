extends CharacterBody2D

enum {
	STILL,
	ATTACKING
}

const SPEED = 12500.0

var state := STILL
var player: CharacterBody2D = null

func _physics_process(delta: float) -> void:
	handle_states(delta)
	move_and_slide()

func handle_states(delta) -> void:
	match state:
		STILL:
			pass
		ATTACKING:
			var direction := Vector2.ZERO
			if player:
				direction = (player.global_position - global_position).normalized()
				velocity = direction * SPEED * delta

func _on_attack_area_body_entered(body: Node2D) -> void:
	%AttackDelay.start()
	player = body

func _on_attack_area_body_exited(body: Node2D) -> void:
	player = body


func _on_attack_delay_timeout() -> void:
	state = ATTACKING