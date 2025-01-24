extends CharacterBody2D


@export var stats: Health
const SPEED: float = 300.0
const JUMP_VELOCITY: float = -450.0
const MAX_AIR_JUMPS: int = 1
var air_jumps: int = MAX_AIR_JUMPS

enum {GROUND, FALLING, JUMPING, SLIDING, ON_WALL, WALL_JUMPING}
var state = GROUND

# -1 is left, 1 is right
var facing: int = 1

signal health_changed(newValue: int)
signal health_reached_zero()

func _ready() -> void:
	health_changed.emit(stats.health)
	$HurtBox.take_damage.connect(_on_take_damage)
	
func _on_take_damage(damage: int) -> void:
	stats.health -= damage
	health_changed.emit(stats.health)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		stats.health -= 50
		health_changed.emit(stats.health)
	if stats.health <= 0:
		health_reached_zero.emit()
		queue_free()

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		if state != ON_WALL:
			state = FALLING
	else:
		state = GROUND
		
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	match state:
		GROUND:
			air_jumps = MAX_AIR_JUMPS
			
			# Handle jump.
			if Input.is_action_just_pressed("jump") && can_jump():
				velocity.y = JUMP_VELOCITY
				state = JUMPING

			if direction:
				facing = direction
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				
		FALLING, JUMPING:
			velocity += get_gravity() * delta
			
			# Handle jump.
			if Input.is_action_just_pressed("jump") && can_jump():
				velocity.y = JUMP_VELOCITY
			
			# Acceleration and deceleration is slower in the air.
			if direction != 0:
				facing = direction
				velocity.x = move_toward(velocity.x, direction * SPEED, 20)
			else:
				velocity.x = move_toward(velocity.x, 0, 20)
				
			if velocity.y > 0 && is_on_wall():
				set_on_wall()
				
		ON_WALL:
			if Input.is_action_just_pressed("jump"):
				state = JUMPING
				velocity.x = facing * SPEED
				velocity.y = JUMP_VELOCITY * 0.75
				# This should probably use a raycast or something else instead of facing checks
			if direction == facing:
				state = FALLING
			velocity += get_gravity() * delta
			velocity.y = min(velocity.y, 50)
			
		SLIDING:
			pass
	
	move_and_slide()

func set_on_wall() -> void:
	state = ON_WALL
	facing = -facing
	print(facing)

func wall_jump() -> void:
	state = WALL_JUMPING
	
func can_jump() -> bool:
	if is_on_floor():
		return true
	if air_jumps > 0:
		air_jumps -= 1
		return true
	return false

func slide() -> void:
	pass
	
