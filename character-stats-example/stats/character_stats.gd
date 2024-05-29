@icon("res://stats/character_stats_icon.svg")
# Create an instance of this class in the FileSystem.
# Right-Click -> Create New -> Resource -> CharacterStats
class_name CharacterStats
extends Resource

signal move_speed_changed(_new_value: float)
signal health_changed(_new_value: float)

## Move Speed of the character. Emits move_speed_changed signal when updated
@export var move_speed : float :
	get:
		return move_speed
	set(_value):
		move_speed = _value
		move_speed_changed.emit(_value)

## Maximum health for the player
@export var max_health = 100

## Heath of the character. Emits health_changed signal when updated
@export var health : float :
	get:
		return health
	set(_value):
		health = clamp(_value, 0, max_health)
		health_changed.emit(health)
