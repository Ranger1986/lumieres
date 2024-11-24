extends Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(self._button_pressed)
	pass # Replace with function body.

func _button_pressed():
	var listeTextureButton : Array
	var G :Gestionnaire = owner.G
	G.grid.cleanCells()
	G.listAct = []
	
	listeTextureButton = owner.find_children("", "TextureButton")
	
	for i in listeTextureButton.size():
		listeTextureButton[i].clean()
		var rand : int = randi() % listeTextureButton[i].textArray.size()
		var tRect : TextureRect = listeTextureButton[i].find_children("", "TextureRect")[0]
		tRect.texture = listeTextureButton[i].textArray[rand]
	owner.G._actionsEnemy()
	Suzanne.suzanneturn=true
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_released() and event.keycode == KEY_SPACE:
		_button_pressed()               
