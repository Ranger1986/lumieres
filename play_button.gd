extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)
	pass # Replace with function body.

func _button_pressed():
	get_tree().change_scene_to_file("res://Scenes/FirstLevel.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
