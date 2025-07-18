extends Node

signal done
#TextureRect.Texture2D = "res://flappy-bird-assets-master/sprites/background-night.png"
@export var pipes_scene: PackedScene
# Before or after game is functioning(start screen)
var game_start : bool = false
# Condition used for function
var game_running : bool = false
# Easier to get where to spawn pipes out of screen
var screen_size
# For calculations for pipe gen
var ground_height := 160.0
# Bird position locking
var locked_position := 267.0
# Just to make sure the pipe is out of scene when spawning
const PIPE_DELAY : int = 100
# Used as integers, for random spawn heights
const PIPE_RANGE : int = 150
# Carries count of success thru pipes
var score := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	print(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_start == false: # just universal solution to put it here...
		# Keeps bird flying before game start
		$Bird.position.y = locked_position
	#for pipe in pipes:
		# Same as parallax textures
		# updates position thru loop
		#pipe.position.x -= 1.50

func start_game():
	# Bird's initially invulnerable; For some reason, ~10 secs on start screen, bird dies.
	get_tree().call_group("bird", "false_start") # Instead of a signal, I did group signaling because it was easier...
	game_start = true
	game_running = true
	$PipeTimer.start()

func new_game():
	get_tree().reload_current_scene() 
	
	#get_tree().call_group("pipe", "queue_free")
	
func game_over():
	game_running = false
	# Freezes all pipe instances.
	get_tree().call_group("pipe", "freeze")
	print("Dead")
	# Stops main scene parallax sprites
	$City.autoscroll.x = 0
	$GroundMain/Ground.autoscroll.x = 0
	# HUD game over.
	done.emit()
	#	add_child(game_over)

	#$Bird.process_mode = Node.PROCESS_MODE_DISABLED
	

	
func scored():
	score += 1
	print(score)
	$HUD.score(score)
	$ScoreSFX.play()



func _on_pipe_timer_timeout() -> void:
	if game_running:
		generate_pipes()
		
	
func generate_pipes():
	# Makes a pipe scene in main
	var pipe = pipes_scene.instantiate()
	# Spawning location is on the edge of the screen horizontally + a cushion space
	pipe.position.x = screen_size.x + PIPE_DELAY
	# Post btw/ the areas of entry properly and make it so that its more centralized positionally
	# Random modifier (-200, 200)
	pipe.position.y = (screen_size.y - ground_height) / 2 + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.scored.connect(scored)
	# Spawns in scene
	add_child(pipe)
