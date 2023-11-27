extends State


@export var move_state: State
@export var attack_state: State
@export var hurt_state: State
@export var death_state: State

var is_input_delayed := false
var is_hold := false
var input_hold_count: float = 0


func enter():
	owner.animator.play("idle")


func exit():
	pass


func process_frame(_delta: float) -> State:
	if Input.is_action_pressed("ui_left"):
		owner.flip_h(true)
		input_hold_count += _delta
		if input_hold_count > 0.15:
			return move_state
	elif Input.is_action_pressed("ui_right"):
		owner.flip_h(false)
		input_hold_count += _delta
		if input_hold_count > 0.15:
			return move_state
	else:
		input_hold_count = 0
	
	return null


func process_physics(_delta: float) -> State:
	if not owner.is_on_floor():
		owner.velocity.y += owner.gravity * _delta
	owner.move_and_slide()
	
	return null


func process_input(_event: InputEvent) -> State:
	if _event.is_action_pressed("ui_end"):
		return attack_state
	
	if _event.is_action_pressed("ui_page_up"):
		return hurt_state
	
	if _event.is_action_pressed("ui_page_down"):
		return death_state
	
	return null
