extends CanvasLayer

signal start
signal restart
# Not hide on editor but when app starts
func _ready() -> void:
	$ScoreLabel.hide()
	$GameOver.hide()
	

	
# Instructional start interface sprite
func _on_texture_button_pressed() -> void:
	$TextureButton.hide()
	$ScoreLabel.show()
	# Main start_game
	start.emit()
	
func score(score):
	$ScoreLabel.text = str(score)
	
func screen_game_over():
	$GameOver.show()
	$RestartTimer.start()
	# If bird dies during start screen
	$TextureButton.hide()
	
	
func _on_restart_timer_timeout() -> void:
	$GameOver.hide()
	#print("gameover")
	$Swoosh.play()
	await $Swoosh.finished
	# Main new_game/restart scene.
	restart.emit()
