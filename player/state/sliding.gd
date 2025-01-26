extends State

# Called at the start of the state's lifecycle
func start() -> void:
	var direction: int = 1 if parent.facing_right else -1
	parent.velocity.x = direction * parent.SPEED * 2
	parent.rotation_degrees = 90
	# $PlaceholderSprite.scale.y = 0.5
	# $PlaceholderSprite.scale.x = 2.0
	
func update(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") && parent.can_jump():
		parent.set_state("jumping")
	elif !parent.is_on_floor():
		parent.set_state("falling")
	elif parent.velocity.x < 40:
		parent.set_state("ground")

# Called every physics frame
func physics_update(_delta: float) -> void:
	parent.rotation_degrees = 90
	parent.velocity.x = move_toward(parent.velocity.x, 0, 20)

# Called when the state is terminated. Use this to clean up.
func stop() -> void:
	parent.rotation_degrees = 0
	# $PlaceholderSprite.scale.y = 1.0
	# $PlaceholderSprite.scale.x = 1.0
	pass
