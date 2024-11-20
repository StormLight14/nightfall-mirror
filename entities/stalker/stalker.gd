extends CharacterBody2D

enum {
	STILL,
	FOLLOWING,
	FLEEING,
	ATTACKING
}

const FOLLOW_SPEED := 500.0
const ATTACK_SPEED := 4250.0

var state := STILL
var player: CharacterBody2D = null
var paused := false

func _physics_process(delta: float) -> void:
	handle_states(delta)
	
	if paused:
		velocity = Vector2.ZERO
	move_and_slide()
	
func handle_states(delta: float):
	var direction := Vector2.ZERO
	if player:
		direction = (player.global_position - global_position).normalized()
	
	match state:
		STILL:
			velocity = Vector2.ZERO
		FOLLOWING:
			velocity = direction * FOLLOW_SPEED * delta
		FLEEING:
			velocity = -direction * ATTACK_SPEED * 3 * delta
		ATTACKING:
			velocity = direction * ATTACK_SPEED * delta

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
		paused = true
		%PauseTimer.start() # stalker pauses before fleeing

func _on_flee_timer_timeout() -> void:
	if state == FLEEING:
		state = STILL


func _on_pause_timer_timeout() -> void:
	%FleeTimer.start()
	paused = false
