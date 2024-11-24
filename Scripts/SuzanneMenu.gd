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