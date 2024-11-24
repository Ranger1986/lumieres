extends ColorRect

@export var G : Gestionnaire
@export var SuzanneImage: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#custom_minimum_size=Vector2i(floor(get_viewport_rect().size.x/3),get_viewport_rect().size.y)
	#position=Vector2i(0, 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hide_suzanne() -> void:
	SuzanneImage.hide()

func show_suzanne() -> void:
	SuzanneImage.show()

func get_suzanne_position() -> Vector2:
	return SuzanneImage.position
	
func _getCapture(text: Texture):
	var pet :Sprite2D = Sprite2D.new()
	pet.texture = text
	pet.offset = Vector2(32,32)
	pet.position = Vector2(0,1) * 64 * find_child("captureContainer").get_child_count()
	find_child("captureContainer").add_child(pet)
