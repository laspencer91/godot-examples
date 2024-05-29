class_name Player
extends CharacterBody2D

@export var stats: CharacterStats

func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * stats.move_speed
	move_and_slide()
