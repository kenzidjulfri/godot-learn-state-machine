@tool
class_name HealthComponent
extends Node

signal death

@export var max_health := 10.0

var _is_dead := false
var _health: float:
	get = get_health


func _ready():
	_health = max_health


func calculate_health(heal: float):
	_health += heal
	if !_is_dead && _health > max_health:
		_health = max_health


func calculate_damage(damage: float):
	_health -= damage
	if _health < 0:
		_health = 0
		_dead()


func get_health():
	return _health


func _dead():
	death.emit()
	_is_dead = true
	get_parent().queue_free()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if !get_parent() is CharacterBody2D:
		warnings.append("Parent of this node must be CharacterNode2D")
	
	return warnings
