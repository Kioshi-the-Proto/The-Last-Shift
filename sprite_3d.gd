extends Sprite3D

@onready var talking_sprite = "res://Untitledr_talk.png"
@onready var no_talking_sprite = "res://Untitledr.png"
@onready var timer1 = $Talk_Timer
@onready var timer2 = $No_Talk_Timer
@onready var AP = $AnimationPlayer
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
	
	#makes regdor always look at player.
	if GameManager.player:
		look_at(GameManager.player.position)


func _on_talk_timer_timeout() -> void:
	talking = true
	timer2.start()
	print("timer 1 happend")

func _on_no_talk_timer_timeout() -> void:
	talking = false
	timer1.start()
	print("timer 2 happend")
