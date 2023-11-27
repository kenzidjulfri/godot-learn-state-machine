@tool
class_name AttackComponent
extends Area2D

@export var attack_damage: float
@export var knockback_force: Vector2
@export var hitstun_time: float

var _attack: Attack


func _ready():
	_attack = Attack.new()
	_attack.damage = attack_damage
	_attack.knockback_force = knockback_force
	_attack.hitstun_time = hitstun_time
	
	self.area_entered.connect(_on_area_entered)


func _on_area_entered(area):
	if area is HurtboxComponent && !_is_self_hurtbox(area):
		var hitbox: HurtboxComponent = area
		hitbox.receive_attack(_attack)


func enable_collision(enabled: bool):
	propagate_call("enable_hitbox", [enabled])


func _is_self_hurtbox(area):
	if area == owner.hurtbox:
		return true
	return false
