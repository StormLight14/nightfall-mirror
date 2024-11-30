extends Polygon2D

@export var shadow_distance = 30

func _ready() -> void:
	Signals.turning_day.connect(turning_day)
	Signals.turning_night.connect(turning_night)

func turning_day(time: float) -> void:
	$AnimationPlayer.speed_scale = 1 / time
	$AnimationPlayer.play("turning_day")

func turning_night(time: float) -> void:
	$AnimationPlayer.speed_scale = 1 / time
	$AnimationPlayer.play("turning_night")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print(anim_name + " finished.")
