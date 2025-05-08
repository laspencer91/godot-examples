class_name AnimationComponent
extends Component

@export var animated_sprite: AnimatedSprite2D

var movement_component: MovementComponent

func _component_ready():
	movement_component = get_component(MovementComponent)

func _physics_process(_delta: float) -> void:
	var velocity = movement_component.body.velocity
	var max_speed = movement_component.max_speed
	
	# Determine animation based on horizontal movement
	if velocity.y > 0:
		animated_sprite.play("jump_down")
	elif velocity.y < 0:
		animated_sprite.play("jump_up")
	elif abs(velocity.x) > 0.1:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
	
	# Flip sprite based on movement direction
	if velocity.x != 0.0:
		animated_sprite.flip_h = velocity.x < -0.1
	
	# Adjust animation speed based on current speed relative to max_speed
	var speed_ratio = clamp(abs(velocity.x) / max_speed, 0.0, 1.0)
	animated_sprite.speed_scale = lerp(0.5, 1.5, speed_ratio)
