extends Button

@export var test : String = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(self._button_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = test
	pass
	
func _button_pressed():
	if test == "Attaque":
		owner.G.giveAct(DiceFace.ATK)
	elif test == "Défense":
		owner.G.giveAct(DiceFace.DEF)
	elif test == "Mouvement":
		owner.G.giveAct(DiceFace.MOV)
