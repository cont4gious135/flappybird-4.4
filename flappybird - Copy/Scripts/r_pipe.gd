extends RigidBody2D

signal scored
# Resource allieviate
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("exited")
	queue_free()
 
# Method to call for pipes to stop in place from propulsion.
func freeze():
	set_deferred("freeze", true)


# Score area
func _on_score_area_body_entered(body: Node2D) -> void:
	scored.emit()
