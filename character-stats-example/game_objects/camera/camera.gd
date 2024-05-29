extends Camera2D

@export var follow_target: Node2D;
@export var follow_speed := 10

func _process(delta):
	if follow_target:
		position = lerp(global_position, follow_target.global_position, follow_speed * delta)
