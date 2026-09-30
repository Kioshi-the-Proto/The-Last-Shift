extends CharacterBody3D


const SPEED = 10
const JUMP_VELOCITY = 4.5

const SENSITIVITY = 0.005
@onready var head = $Head #lost my head
@onready var cam = $Head/Camera3D

func _physics_process(delta: float) -> void:
	# Add the down gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jumps, hops, or skips
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

#dif movement keys to do stuff
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis*Vector3(input_dir.x,0,input_dir.y))
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	#keep this does movement stuff
	move_and_slide()
func _ready(): #THIS STUFF DOES THE CAMREA DO NOT TOUCH!
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _unhandled_input(event):
	if event is InputEventMouse:
		head.rotate_y(-event.relative.x*SENSITIVITY)
		cam.rotate_x(-event.relative.y*SENSITIVITY)
		cam.rotation.x = clamp(cam.rotation.x,deg_to_rad(-40),deg_to_rad(60	))

	
