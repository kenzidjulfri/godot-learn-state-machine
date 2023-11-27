@tool
class_name StateMachine
extends Node


@export var initial_state: State = null

var current_state: State = null


func init():
	if !initial_state:
		initial_state = get_first_state()
	
	change_state(initial_state)


func process_frame(delta):
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)


func process_physics(delta):
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)


func process_input(event):
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)


func change_state(new_state: State):
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()


func get_first_state() -> State:
	for child in get_children():
		if child is State:
			return child
	
	return null


func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if get_child_count() == 0:
		warnings.append("StateMachine must have at least one child ")
	elif !get_first_state():
		warnings.append("StateMachine must have at least one child with a type of State")
		
	return warnings
