extends CharacterBody2D

enum {
	STILL,
	FOLLOWING,
	FLEEING,
	ATTACKING
}

const FOLLOW_SPEED := 500.0
const ATTACK_SPEED := 4500.0

var state := STILL
var player: CharacterBody2D = null

func _physics_process(delta: float) -> void:
	var direction := Vector2.ZERO
	if player:
		direction = (player.global_position - global_position).normalized()
	
	match state:
		STILL:
			velocity = Vector2.ZERO
		FOLLOWING:
			velocity = direction * FOLLOW_SPEED * delta
		FLEEING:
			velocity = -direction * ATTACK_SPEED * 1.2 * delta
		ATTACKING:
			velocity = direction * ATTACK_SPEED * delta
	move_and_slide()

func _on_follow_area_body_entered(body: Node2D) -> void:
	player = body
	if state == STILL:
		state = FOLLOWING

func _on_follow_area_body_exited(body: Node2D) -> void:
	player = body
	if state == FOLLOWING:
		state = STILL

func _on_attack_area_body_entered(body: Node2D) -> void:
	player = body
	if state == FOLLOWING:
		state = ATTACKING
		%AttackTimer.start()

func _on_attack_area_body_exited(body: Node2D) -> void:
	player = body
	if state == ATTACKING:
		state = FOLLOWING

func _on_attack_timer_timeout() -> void:
	if state == ATTACKING:
		state = FLEEING
		%FleeTimer.start()

func _on_flee_timer_timeout() -> void:
	if state == FLEEING:
		state = STILL
