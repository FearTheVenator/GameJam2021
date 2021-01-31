extends KinematicBody
var gravity = -9.8
var velocity = Vector3()
onready var camera = $Pivot/Camera
var mouse_sensitivity = 0.002

const SPEED = 6
const ACCELERATION = 3
const DE_ACCELERATION = 5

var player = AudioStreamPlayer.new()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#camera = get_node("../Camera").get_global_transform()
	# Footsteps sound effect setup
	self.add_child(player)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	player.stream = load("res://Music/Footstep.ogg")
func get_input():
	var input_dir = Vector3()
	# desired move in camera direction

	if Input.is_action_pressed("ui_up"):
		input_dir += -camera.global_transform.basis.z
		if !player.playing:
			player.play()
	if Input.is_action_pressed("ui_down"):
		input_dir += camera.global_transform.basis.z
		if !player.playing:
			player.play()
	if Input.is_action_pressed("ui_left"):
		input_dir += -camera.global_transform.basis.x
		if !player.playing:
			player.play()
	if Input.is_action_pressed("ui_right"):
		input_dir += camera.global_transform.basis.x
		if !player.playing:
			player.play()
	#if Input.is_action_just_pressed("ui_select"):
		#input_dir += camera.global_transform.basis.y
	input_dir = input_dir.normalized()
	return input_dir
		
func _physics_process(delta):
	velocity.y += gravity * delta
	var desired_velocity = get_input() * SPEED

	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	if velocity != Vector3():
		#if is_network_master():
			velocity = move_and_slide(velocity, Vector3.UP, true)
		#rpc_unreliable("_set_position", global_transform.origin)
func _unhandled_input(event):
	#if is_network_master():
		if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			rotate_y(-event.relative.x * mouse_sensitivity)
			$Pivot.rotate_x(event.relative.y * mouse_sensitivity)
			$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2)
func _input(event):
	#if is_network_master():
		if event.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if event.is_action_pressed("shoot"):
			if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#remote func _set_position(pos):
	#global_transform.origin = pos
	
