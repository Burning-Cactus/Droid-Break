extends State

# Called at the start of the state's lifecycle
func start() -> void:
	parent.air_jumps = parent.MAX_AIR_JUMPS

# Called every frame
func update(_delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		
		return
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") && parent.can_jump():
		parent.set_state("jumping")
	elif Input.is_action_just_pressed("slide"):
		parent.set_state("sliding")
	elif !parent.is_on_floor():
		parent.set_state("falling")
	parent.face_forward()

# Called every physics frame
func physics_update(_delta: float) -> void:
	var direction: int = Input.get_axis("move_left", "move_right")
	if direction:
		parent.facing_right = direction > 0
		parent.velocity.x = direction * parent.SPEED
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, parent.SPEED)

# Called when the state is terminated. Use this to clean up.
func stop() -> void:
	pass
