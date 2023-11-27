@tool
class_name HitBoxCollision
extends CollisionShape2D

func _ready():
	enable_hitbox(false)

func enable_hitbox(enabled: bool):
	visible = enabled
	disabled = !enabled
