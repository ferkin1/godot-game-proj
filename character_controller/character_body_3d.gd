extends CharacterBody3D
var speed = 5.0
var gravity = 30.0
var jump = 10.0
@export var mouse_sensitivity := 0.005

@onready var Camera_pivot: Node3D = $Camera_pivot

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event: InputEvent):
		if event is InputEventMouseMotion:
			#Hor rotation
			rotate_y(-event.relative.x * mouse_sensitivity)
			
			#Vert rotation
			Camera_pivot.rotate_x(-event.relative.y * mouse_sensitivity)
			
			#Clamp vertical rotation to avoid flipping
			var rot_deg = Camera_pivot.rotation_degrees
			rot_deg.x = clamp(rot_deg.x, -60, 30)
			Camera_pivot.rotation_degrees = rot_deg

func _physics_process(delta: float) -> void:

	var direction = Vector3.ZERO
	# Basic movement
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_back"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x
	if Input.is_action_pressed("move_jump"):
		direction += transform.basis.y
		
	direction = direction.normalized()
	# Horizontal movment
	var horizontal_velocity=speed*direction
	velocity.x=horizontal_velocity.x
	velocity.z=horizontal_velocity.z
	
	
	# Gravity
	if not is_on_floor():
		velocity.y -= gravity*delta
	else:
		if Input.is_action_pressed("move_jump"):
			velocity.y = jump
	move_and_slide()	
func _handle_camera_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * 0.1))
		# or call your custom camera pivot logic here

	
		
	
	
