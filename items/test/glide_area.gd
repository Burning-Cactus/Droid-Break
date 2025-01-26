extends Area2D
@onready var soup: CharacterBody2D = $"../Soup"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	BodyEntired()
func BodyEntired(body):
	print("Testing")


func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
