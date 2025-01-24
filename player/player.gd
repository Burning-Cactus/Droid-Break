extends CharacterBody2D

@export var stats: Health
const SPEED: float = 300.0
const JUMP_VELOCITY: float = -450.0
const MAX_AIR_JUMPS: int = 1
var air_jumps: int = MAX_AIR_JUMPS

# -1 is left, 1 is right
var facing: int = 1

signal health_changed(newValue: int)
signal health_reached_zero()

var states: Dictionary = {}
var active_state: State

func _ready() -> void:
	health_changed.emit(stats.health)
	$HurtBox.take_damage.connect(_on_take_damage)
	
	for state in $StateMachine.get_children():
		assert(state is State, "ERROR: Non-state node included in state machine!")
		
		state.parent = self
		
		states[state.name.to_lower()] = state
	
	active_state = states.values()[0]
	
	for node in states.values():
		print("State: ", node)
	
func _on_take_damage(damage: int) -> void:
	stats.health -= damage
	health_changed.emit(stats.health)

func _process(delta: float) -> void:
	if stats.health <= 0:
		health_reached_zero.emit()
		queue_free()
	active_state.update(delta)

func _physics_process(delta: float) -> void:
	active_state.physics_update(delta)
				
		# ON_WALL:
		# 	if Input.is_action_just_pressed("jump"):
		# 		state = JUMPING
		# 		velocity.x = facing * SPEED
		# 		velocity.y = JUMP_VELOCITY * 0.75
		# 		# This should probably use a raycast or something else instead of facing checks
		# 	if direction == facing:
		# 		state = FALLING
		# 	velocity += get_gravity() * delta
		# 	velocity.y = min(velocity.y, 50)
				
	
	move_and_slide()

func set_state(name: String) -> void:
	print("Old state: ", active_state.name, " New state: ", name)
	active_state.stop()
	active_state = states[name]
	active_state.start()

func set_on_wall() -> void:
#	state = ON_WALL
	facing = -facing
	print(facing)

func wall_jump() -> void:
#	state = WALL_JUMPING
	pass
	
func can_jump() -> bool:
	if is_on_floor():
		return true
	if air_jumps > 0:
		air_jumps -= 1
		return true
	return false
