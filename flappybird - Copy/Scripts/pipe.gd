extends Node2D

signal hit



# The killzones arent connected to the rigidbody from the pipe scene
# Possible solution is to try to make the killzone move accordingly with the rigid body or figure out signaling again


func _on_hit() -> void:
	hit.emit()
