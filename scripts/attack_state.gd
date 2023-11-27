extends State


@export var idle_state: State
@export var attack_component: AttackComponent

@onready var delay_timer := $DelayTimer

var is_locked := true
var is_charged_up := false
var direction := 1


func enter():
	owner.animator.play("attack")
	delay_timer.start(0.4)


func exit():
	owner.velocity.x = 0


func process_frame(_delta: float) -> State:
	if !is_locked:
		is_locked = true
		return idle_state
	return null


func process_physics(_delta: float) -> State:
	if owner.is_flipped:
		direction = -1
	else:
		direction = 1
	attack_component.scale = Vector2(direction, 1)
	
	if is_charged_up && is_locked:
		owner.velocity.x = direction * owner.SPEED
	
	owner.move_and_slide()
	return null


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		is_locked = false
		is_charged_up = false
		attack_component.enable_collision(false)


func _on_delay_timer_timeout():
	is_charged_up = true
	attack_component.enable_collision(true)
