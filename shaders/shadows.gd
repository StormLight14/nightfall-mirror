extends Polygon2D

func _ready() -> void:
	Signals.turning_day.connect(turning_day)
	Signals.turning_night.connect(turning_night)

func turning_day(time: float) -> void:
	$AnimationPlayer.speed_scale = 1 / time
	$AnimationPlayer.play("turning_day")
	print("turning day anim")

func turning_night(time: float) -> void:
	$AnimationPlayer.speed_scale = 1 / time
	print($AnimationPlayer.speed_scale)
	$AnimationPlayer.play("turning_night")
	print("turning night anim")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print(anim_name + " finished.")
