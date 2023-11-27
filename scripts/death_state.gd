extends State


#func _ready():
#	var animation_library = owner.animator.get_animation_library("")
#	var animation = animation_library.get_animation("death")
#	var track = animation.add_track(Animation.TYPE_VALUE)
#	animation.track_set_path(track, "../Player:position")
#	var position = owner.position
#	animation.track_insert_key(track, 0, position)
#	animation.track_insert_key(track, 0.5, position)
#	position.y -= 50
#	animation.track_insert_key(track, 0.3, position)
#	#animation.loop_mode = Animation.LOOP_LINEAR


func enter():
	owner.animator.play("death")
	owner.velocity.y += 1000


func process_physics(_delta: float) -> State:
	if not owner.is_on_floor():
		owner.velocity.y += owner.gravity * _delta
	
	owner.move_and_slide()
	return null
