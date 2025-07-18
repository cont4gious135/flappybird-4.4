extends CharacterBody2D

signal hit
var screen_size
var rotation_speed
var input_enabled : bool = true

var game_started : bool = false

const SPEED = 300.0
const JUMP_VELOCITY = -450.0

func _ready() -> void:
	screen_size = get_viewport_rect().size
	
	$AnimatedSprite2D.play()
	
func _process(delta: float) -> void:
	# Cap height; prevent exiting viewport
	position = position.clamp(Vector2.ZERO, screen_size)
	self.position.x = 117.0
	
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if input_enabled:
		# Handle jump.
		if Input.is_action_just_pressed("flap"):
			velocity.y = JUMP_VELOCITY
			$FlapSFX.play()
			

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	
	
	
	

	

#	if JUMP_VELOCITY > -450.0:

#func rotate_bird():
	# Rotate downwards when falling
	#if velocity.y > 0 && rad_to_deg(rotation) < 90:
		#rotation += rotation_speed * deg_to_rad(1)
	# Rotate upwards when rising
	#elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		#rotation -= rotation_speed * deg_to_rad(1)
		


	move_and_slide()
func false_start():
	game_started = true
	
func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if game_started:
		print("vitality")
		$HitSFX.play()
		$DieSFX.play()
		$AnimatedSprite2D.pause()
		input_enabled = false
		print(input_enabled)
		hit.emit()
