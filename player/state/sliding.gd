extends State

# Called at the start of the state's lifecycle
func start() -> void:
	parent.velocity.x = parent.facing * parent.SPEED * 2
	$PlaceholderSprite.scale.y = 0.5
	$PlaceholderSprite.scale.x = 2.0
	
func update(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") && parent.can_jump():
		parent.set_state("jumping")

# Called every physics frame
func physics_update(_delta: float) -> void:
	parent.velocity.x = move_toward(parent.velocity.x, 0, 4)

# Called when the state is terminated. Use this to clean up.
func stop() -> void:
	$PlaceholderSprite.scale.y = 1.0
	$PlaceholderSprite.scale.x = 1.0
