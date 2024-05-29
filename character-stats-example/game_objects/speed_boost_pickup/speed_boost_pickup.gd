class_name SpeedBoostPickup
extends Area2D

## How much speed to add when picked up by the player.
@export var speed_boost_amount := 5.0

## Assigned in inspector. Same as the one connected to the Player object.
@export var player_stats: CharacterStats

func _ready():
	body_entered.connect(_on_body_entered)

func consume():
	# Because the player_stats reference will be the same one connected to the player,
	# updating its stats will update the players stats, and notify all listeners
	# of the move_speed_updated signal on that resource!
	player_stats.move_speed += speed_boost_amount
	
func _on_body_entered(other: Node2D):
	if other is Player:
		consume()
		queue_free()
