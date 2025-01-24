class_name State
extends Node

# Base class for all states that a player can be in.
var parent: CharacterBody2D

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
