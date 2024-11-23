extends Sprite2D

var map : TileMapLayer;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map = owner.find_child("Grid")
	scale *= map.tile_set.tile_size.x / texture.get_size().x
	offset = texture.get_size()/2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
