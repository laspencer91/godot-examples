class_name Healthbar
extends ProgressBar

## This healthbar respresents health from the assigned CharacterStats ref
@export var character_stats: CharacterStats

func _ready():
	value = character_stats.health
	max_value = character_stats.max_health
	character_stats.health_changed.connect(on_health_changed)
	
func on_health_changed(_new_val: float):
	value = _new_val
