extends CharacterBody3D

const CROUCH_SPEED = 2
const CRAWL_SPEED = 1
const WALKING_SPEED = 4
const SPRINT_SPEED = 9
const JUMP_VELOCITY = 4

var TRUE_SPEED = WALKING_SPEED
var IS_CROUCHING = false
var IS_CRAWLING = false

const SENSITIVITY = 0.005
@onready var head = $Head #lost my head
@onready var cam = $Head/Camera3D
@onready var mesh = $MeshInstance3D

func _physics_process(delta: float) -> void:
	# Add the down gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jumps, hops, or skips
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("crouch"):
		if IS_CROUCHING == false:
			movementStateChange("crouch")
			TRUE_SPEED = CROUCH_SPEED
		elif IS_CROUCHING == true: 
			movementStateChange("uncrouch")
			TRUE_SPEED = WALKING_SPEED
	elif Input.is_action_just_pressed("crawl"):
		if IS_CRAWLING == false:
			movementStateChange("crawl")
			TRUE_SPEED = CRAWL_SPEED
		elif IS_CRAWLING == true:
			movementStateChange("uncrawl")
			TRUE_SPEED = WALKING_SPEED
			
#dif movement keys to do stuff
	var input_dir := Input.get_vector("left", "right", "up", "down")
#makes the direction fo head to be front
	var direction = (head.transform.basis*Vector3(input_dir.x,0,input_dir.y)).normalized()
	if direction:
		if Input.is_action_pressed("sprint"):
			TRUE_SPEED = SPRINT_SPEED
		velocity.x = direction.x * TRUE_SPEED
		velocity.z = direction.z * TRUE_SPEED
	
	else:
		velocity.x = move_toward(velocity.x, 0, TRUE_SPEED)
		velocity.z = move_toward(velocity.z, 0, TRUE_SPEED)
	#keep this does movement stuff
	move_and_slide()
	
func movementStateChange(changeType):
	match changeType:
		"crouch":
			if IS_CRAWLING:
				$AnimationPlayer.play_backwards("CrouchToCrawl")
			else:
				$AnimationPlayer.play("StandingToCrouch")
				IS_CROUCHING = true 
				#change collision to crouching
				IS_CRAWLING = false
		"uncrouch":
			$AnimationPlayer.play_backwards("StandingToCrouch")
			IS_CROUCHING = false
			IS_CRAWLING = false
			#change collision to standing

		"crawl":
			if IS_CROUCHING:
				$AnimationPlayer.play("CrouchToCrawl")
			else:
				$AnimationPlayer.play("StandingToCrawl")
			IS_CROUCHING = false
			IS_CRAWLING = true
			#change collision to crawling

		"uncrawl":
			$AnimationPlayer.play_backwards("StandingToCrawl")
			IS_CRAWLING = false
			IS_CRAWLING = false
			#change collision to standing
			
func changeCollisionShapeTo(shape):
	match shape:
		"crouching":
			$CrouchingCollisionShape.disabled = false
			$CrawlingCollisionShape.disabled = true
			$StandingCollisionShape.disabled = true
		"standing":
			$StandingCollisionShape.disabled = false
			$CrawlingCollisionShape.disabled = true
			$CrouchingCollisionShape.disabled = true
		"crawling":
			$CrawlingCollisionShape.disabled = false
			$StandingCollisionShape.disabled = true
			$CrouchingCollisionShape.disabled = true
func _ready(): #THIS STUFF DOES THE CAMREA DO NOT TOUCH!
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _unhandled_input(event):
	if event is InputEventMouse:
		head.rotate_y(-event.relative.x*SENSITIVITY)
		cam.rotate_x(-event.relative.y*SENSITIVITY)
		cam.rotation.x = clamp(cam.rotation.x,deg_to_rad(-40),deg_to_rad(60	))

	


	
