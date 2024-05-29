class_name ScreenFlasher
extends ColorRect

@export var time_to_disappear = 0.2

func _ready():
	modulate.a = 0.0
	
func flash():
	modulate.a = 1.0
	get_tree().create_tween().tween_property(self, "modulate:a", 0.0, time_to_disappear)
