extends State

var timer: Timer
@export var time: float = 0.3

var facing: bool = 0

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	parent.set_state("ground")

# Called at the start of the state's lifecycle
func start() -> void:
	var direction: int = 1 if parent.facing_right else -1
	parent.velocity.x = direction * parent.SPEED * 2
	timer.start(time)
	
func update(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") && parent.can_jump():
		parent.set_state("jumping")
		return
	if !parent.is_on_floor():
		parent.set_state("falling")
		return
	var direction: int = Input.get_axis("move_left", "move_right")
	if sign(direction) != sign(parent.velocity.x):
		parent.set_state("ground")

# Called every physics frame
func physics_update(_delta: float) -> void:
	# parent.velocity.x = move_toward(parent.velocity.x, 0, 20)
	pass

# Called when the state is terminated. Use this to clean up.
func stop() -> void:
	timer.stop()
