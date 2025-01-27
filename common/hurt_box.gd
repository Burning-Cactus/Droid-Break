class_name HurtBox
extends Area2D

# A hurtbox for registering attacks from other sources.
# If it detects a hitbox on the same layer, it will fire a signal with the damage taken.

signal take_damage(damage: int)

func damage(damage: int) -> void:
	take_damage.emit(damage)
