extends Node

@onready var startText: Label = $PanelContainer/MarginContainer/StartText
var simultaneous_scene = preload("res://Maps/base.tscn").instantiate()
func _process(delta):
	
	if Input.is_action_just_pressed("EnterKey"):
		_add_a_scene_manually()
func _add_a_scene_manually():
	# This is like autoloading the scene, only
	# it happens after already loading the main scene.
	get_tree().root.add_child(simultaneous_scene)
	get_node("PanelContainer").free()
