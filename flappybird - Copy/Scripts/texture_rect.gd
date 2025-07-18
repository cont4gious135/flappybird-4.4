extends TextureRect
# ---------Organized code----------

# Easy view of variating background texture through array to funnel into texture choosing
@export var TEXTURE_VARIATIONS_ARRAY: Array = [
	preload("res://flappy-bird-assets-master/sprites/background-day.png"),
	preload("res://flappy-bird-assets-master/sprites/background-night.png")
]
# Initiates the variating function
func _ready():
	variate_texture()

func variate_texture():
	# Justifies that there has to be more than 1 texture to choose
	if TEXTURE_VARIATIONS_ARRAY.size() > 1:
		# Creates a new variable of int that randomly chooses from the array #'s
		var texture_id: int = randi() % TEXTURE_VARIATIONS_ARRAY.size()
		# Texture variable that selects from the array with the selected random number
		var chosen_texture: Texture = TEXTURE_VARIATIONS_ARRAY[texture_id]
		# loads the variable into texture
		texture = chosen_texture
