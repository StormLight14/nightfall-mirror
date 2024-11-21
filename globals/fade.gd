extends CanvasLayer

func play(anim_name: String) -> void:
	$AnimationPlayer.play(anim_name)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Signals.fade_completed.emit(anim_name)
