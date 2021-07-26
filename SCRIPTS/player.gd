extends KinematicBody
#set variables
export var speed = 7
export var acceleration = 5
export var gravity = 3
export var jump_power = 0
export var mouse_sensitivity = 0.5
export var run_multiplier = 2

const ANIMSMOOTH = 8.0
const SWAY = 5

onready var head = $Head
onready var camera = $Head/Camera

onready var player = $"."

#SWAY PART
onready var hand = $Head/Hand
onready var handloc = $Head/Handloc

var anim_blend = 0
var running = false
var run = 1
var velocity = Vector3()
var camera_x_rotation = 0




func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#SWAY
	hand.set_as_toplevel(true)
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))
		
func apply_gravity():
	velocity.y -= gravity

func get_controls(delta):
	
	var head_basis = head.get_global_transform().basis
	var direction = Vector3()
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.is_action_pressed("move_forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += head_basis.z
		
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("move_right"):
		direction += head_basis.x
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction * speed * run, acceleration * delta)
	
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y += jump_power
	velocity = move_and_slide(velocity, Vector3.UP)
	
	if Input.is_action_just_pressed("run"):
		running = true
		run = run_multiplier
	if Input.is_action_just_released("run"):
		running = false
		run = 1
		
#func flashlight_control(delta):
##	Turn on and off
#	if Input.is_action_just_pressed("flashlight") and flashlight:
#		flashlight_light.visible = !flashlight_light.visible
#	hand.global_transform.origin = handloc.global_transform.origin
#	hand.rotation.y = lerp_angle(hand.rotation.y, rotation.y, SWAY * delta)
#	hand.rotation.x = lerp_angle(hand.rotation.x, head.rotation.x, SWAY * delta)

func _process(_delta: float) -> void:
#	flashlight_control(delta)
	pass

func _physics_process(delta: float) -> void:
	get_controls(delta)
	apply_gravity()
	
