extends CharacterBody2D
var elapsed_time = 0.0
var second_pass_time = 2.0 
const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const GlideForce = -.8
var TrueGlide = false
var TrueGlideActive = false
var TrueGlideUpgradeCheck = false
var IsRIght = true
var IsDashReady = true

@onready var sprite_2d: AnimatedSprite2D = $PlayerModel
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var glide_area: Area2D = $"../GlideArea"
func _ready() -> void:
	add_to_group("player")

func _process(delta):
	var IsLeft = velocity.x < 0
	# Check if the left mouse button is pressed
	if Input.is_action_pressed("left"):
		sprite_2d.flip_h = IsLeft
		IsRIght = false
	if Input.is_action_pressed("right"):
		sprite_2d.flip_h = IsLeft
		IsRIght = true


func _physics_process(delta: float) -> void:
	if (velocity.x || velocity.x < -1):
		sprite_2d.animation = "Running"
	else:
		sprite_2d.animation = "Idel"
	if Input.is_action_pressed("QWasPressed"):
		if IsDashReady:
			if IsRIght:
				velocity.x = 1000
			else:
				velocity.x = -1000
			IsDashReady = false
	# Add the gravity.
	if TrueGlideActive == false:
		if TrueGlideUpgradeCheck == true:
			TrueGlideActiveCheck()
	if not is_on_floor():
		elapsed_time += delta
		velocity += get_gravity() * delta
		sprite_2d.animation = "Jumping"
		if TrueGlideActive == true:
			if Input.is_action_just_pressed("up"):
				TrueGlide = true
			if Input.is_action_pressed("up"):
				if TrueGlide:
					velocity += (get_gravity() * delta) * GlideForce

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		elapsed_time = 0
		TrueGlide = false
		velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 20)

	move_and_slide()
func TrueGlideActiveCheck():
	if Input.is_action_pressed("EWasPressed"):
		TrueGlideActive = true
func _on_glide_area_body_entered(body: Node2D) -> void:
	TrueGlideUpgradeCheck = true
	print("Entred")

func _on_glide_area_body_exited(body: Node2D) -> void:
	TrueGlideUpgradeCheck = false
	print("left")

func _on_timer_timeout() -> void:
	print("Timer has finished")
	IsDashReady = true
