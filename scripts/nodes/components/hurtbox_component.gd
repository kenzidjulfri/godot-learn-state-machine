@tool
class_name HurtboxComponent
extends Area2D


@export var health_component: HealthComponent


func receive_attack(attack: Attack):
	if health_component:
		health_component.calculate_damage(attack.damage)


func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if !health_component:
		warnings.append("Health component must be assigned")
	
	return warnings
