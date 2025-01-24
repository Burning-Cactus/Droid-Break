# meta-description: Prefilled methods to override in state
# meta-default: true

extends State

# Called at the start of the state's lifecycle
func start() -> void:
	pass

# Called every frame
func update(_delta: float) -> void:
	pass

# Called every physics frame
func physics_update(_delta: float) -> void:
	pass

# Called when the state is terminated. Use this to clean up.
func stop() -> void:
	pass
