extends CharacterBody2D


@export var animator: AnimationPlayer
@export var is_player_controlled = false

@onready var state_machine = $StateMachine
@export var sprite_main: Sprite2D
@onready var hurtbox = $HurtboxComponent

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_flipped = false


func _ready():
	add_calculated_animation()
	state_machine.init()


func _physics_process(delta):
	state_machine.process_physics(delta)


func _process(delta):
	state_machine.process_frame(delta)


func _unhandled_input(event):
	state_machine.process_input(event)


func flip_h(flipped: bool):
	is_flipped = flipped
	sprite_main.flip_h = flipped


func add_calculated_animation():
	var animation_library = animator.get_animation_library("")
	var animation = animation_library.get_animation("attack")
	var track = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(track, "./CollisionShape2D:position")
	var actual_pos = get_node("./CollisionShape2D").position
	animation.track_insert_key(track, 0, actual_pos)
	animation.track_insert_key(track, 0.5, actual_pos)
	var actual_y = sprite_main.get_texture().get_size().y
	var transformed_y = roundi(0.8 * actual_y)
	var new_pos = (transformed_y - actual_y)/2
	
	actual_pos.y += new_pos
	animation.track_insert_key(track, 0.4, actual_pos)
