extends ColorRect

@export var G : Gestionnaire

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	custom_minimum_size=Vector2i(get_viewport_rect().size.x - self.size.x, get_viewport_rect().size.y)  # indépendant de la taille du rect 
	position=Vector2i(get_viewport_rect().size.x - self.size.x, 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass