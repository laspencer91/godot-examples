class_name PlayableArea
extends Area2D

var play_start_position: Vector2

func _ready():
	play_start_position = (get_tree().get_first_node_in_group("player") as PlatformerPlayer).global_position
	body_exited.connect(_check_if_player_left)
	
func _check_if_player_left(body: Node2D):
	if (body is PlatformerPlayer):
		body.global_position = play_start_position
