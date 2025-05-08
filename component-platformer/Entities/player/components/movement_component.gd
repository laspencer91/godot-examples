class_name MovementComponent
extends Component

@export var body: CharacterBody2D

# Movement parameters
@export var max_speed: float = 300.0
@export var acceleration: float = 1500.0
@export var friction: float = 1000.0
@export var jump_force: float = 800.0
@export var gravity: float = 2200.0

# State tracking
var can_jump: bool = false
var is_falling_through: bool = false
var fallthrough_timer: float = 0.0

func _physics_process(delta: float) -> void:
	var direction: float = Input.get_axis("ui_left", "ui_right")
	
	if not body.is_on_floor():
		body.velocity.y += gravity * delta
	
	if body.is_on_floor():
		can_jump = true
	
	var cancel_jump = false
	# Handle fallthrough input (down + jump)
	var platform = get_standing_platform()
	if platform and platform.is_in_group("fallthrough_platforms"):
		if Input.is_action_pressed("ui_down") and Input.is_action_just_pressed("ui_accept"):
			cancel_jump = true
			body.global_position.y += 1
			
	if not cancel_jump:
		if Input.is_action_just_pressed("ui_accept") and can_jump:
			body.velocity.y = -jump_force
			can_jump = false
		elif Input.is_action_just_released("ui_accept") and body.velocity.y < 1:
			body.velocity.y *= 0.5
	
	# Horizontal movement
	if direction != 0:
		if sign(direction) != sign(body.velocity.x) and body.velocity.x != 0:
			body.velocity.x = move_toward(body.velocity.x, 0, friction * delta)
		body.velocity.x = move_toward(body.velocity.x, direction * max_speed, acceleration * delta)
	else:
		body.velocity.x = move_toward(body.velocity.x, 0, friction * delta)
	
	body.move_and_slide()

# Returns the Node the player is standing on, or null if not on a platform
func get_standing_platform() -> Node:
	if not body.is_on_floor():
		return null
	
	# Check the last collision from move_and_slide
	for i in body.get_slide_collision_count():
		var collision = body.get_slide_collision(i)
		var normal = collision.get_normal()
		# Check if the collision is with a floor (normal points up)
		if normal.y < -0.5:  # Adjust threshold as needed
			var collider = collision.get_collider()
			if collider:
				return collider
	return null
