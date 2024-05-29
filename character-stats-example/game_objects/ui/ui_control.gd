extends Control

## Same reference as the one assigned to the Player Object
@export var player_stats: CharacterStats

## Flash to play when move speed item is picked up
@export var move_speed_screen_flash: ScreenFlasher

func _ready():
	player_stats.move_speed_changed.connect(on_move_speed_change)

func on_move_speed_change(_new_move_speed: float):
	move_speed_screen_flash.flash()
