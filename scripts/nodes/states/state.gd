@tool
class_name State
extends Node


func enter():
	pass


func exit():
	pass


func process_frame(_delta: float) -> State:
	return null


func process_physics(_delta: float) -> State:
	return null


func process_input(_event: InputEvent) -> State:
	return null
