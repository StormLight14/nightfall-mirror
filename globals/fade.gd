extends CanvasLayer

func fade_in() -> void:
	$AnimationPlayer.play("fade_in")

func fade_out() -> void:
	$AnimationPlayer.play("fade_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Signals.fade_completed.emit(anim_name)
