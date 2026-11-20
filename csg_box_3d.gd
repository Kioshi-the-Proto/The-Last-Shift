extends CSGBox3D
var ahh = false
@onready var AP = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ahh:
		AP.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if ahh == false:
		ahh = true
	else:
		ahh = false
