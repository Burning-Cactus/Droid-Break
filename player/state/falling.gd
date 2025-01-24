extends State

# Called at the start of the state's lifecycle
func start() -> void:
	pass
	
func update(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") && parent.can_jump():
		parent.set_state("jumping")
	

# Called every physics frame
func physics_update(delta: float) -> void:
	# parent.velocity.x = move_toward(parent.velocity.x, 0, 4)
	
	parent.velocity += parent.get_gravity() * delta
	
	var direction := Input.get_axis("move_left", "move_right")
	
	# Acceleration and deceleration is slower in the air.
	if direction:
		parent.facing = direction
		parent.velocity.x = move_toward(parent.velocity.x, direction * parent.SPEED, 20)
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, 20)
		
	if parent.is_on_floor():
		parent.set_state("ground")
	#elif parent.velocity.y > 0 && parent.is_on_wall():
	#	set_on_wall()

# Called when the state is terminated. Use this to clean up.
func stop() -> void:
	pass
