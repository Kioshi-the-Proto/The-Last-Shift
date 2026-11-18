extends Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.player:
		look_at(GameManager.player.global_position)
