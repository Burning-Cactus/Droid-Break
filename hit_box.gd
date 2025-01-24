class_name HitBox
extends Area2D

# A hit box for dealing damage to other objects. 
# If it collides with any hurtboxes, it will attempt to deal damage.

const power: int = 4

func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		var hurtbox: HurtBox = area
		hurtbox.damage(power)
