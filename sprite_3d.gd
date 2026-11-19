extends Sprite3D

@onready var talking_sprite = "res://Untitledr_talk.png"
@onready var no_talking_sprite = "res://Untitledr.png"
@onready var timer1 = $Talk_Timer
@onready var timer2 = $No_Talk_Timer
@onready var AP = $AnimationPlayer
@onready var rot: Node3D = $rot

var velocity: Vector3 = Vector3.ZERO
var max_speed = 50
var acceleration = 15
var talking = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer2.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if talking:
		AP.play("talk")
	else:
		AP.play("no_talk")
	
	#make regdor look at u
	global_rotation.y = rot.global_rotation.y
	
	#make regdor move
	var direction := global_position.direction_to(GameManager.player.global_position)
	
	velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	global_position += velocity * delta
	


func _on_talk_timer_timeout() -> void:
	talking = true
	timer2.start()
	print("timer 1 happend")

func _on_no_talk_timer_timeout() -> void:
	talking = false
	timer1.start()
	print("timer 2 happend")
