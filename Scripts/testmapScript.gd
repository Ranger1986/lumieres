extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var mouseEvent : InputEventMouseButton = event
		print(floor(mouseEvent.position.x/64))
		print(floor(mouseEvent.position.y/64))