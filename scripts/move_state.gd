extends State


@export var idle_state: State

@onready var delay_timer := $DelayTimer

var is_locked := true
var is_delayed := true


func enter():
	owner.animator.play("move")
	delay_timer.start(0.2)


func exit():
	owner.velocity.x = 0


func process_frame(_delta: float) -> State:
	if !is_delayed && !is_locked:
		is_locked = true
		is_delayed = true
		return idle_state
	
	return null


func process_physics(_delta: float) -> State:
	if !is_delayed && is_locked:
		var direction = -1 if owner.is_flipped else 1
		owner.velocity.x = direction * owner.SPEED
	
	owner.move_and_slide()
	return null


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "move":
		is_locked = false


func _on_delay_timer_timeout():
	is_delayed = false
