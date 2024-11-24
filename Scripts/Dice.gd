extends TextureButton

@export var textArray : Array[Texture]

# 0 -> Texture Attaque
# 1 -> Texture Defense
# 2 -> Texture Mouvement

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textArray.append(load("res://Ressources/Attaque.png"))
	textArray.append(load("res://Ressources/Defense.png"))
	textArray.append(load("res://Ressources/Mouvement.png"))
	pressed.connect(self._button_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _button_pressed():
	pass
	#if test == "Attaque":
		#owner.G.giveAct(DiceFace.ATK)
	#elif test == "Défense":
		#owner.G.giveAct(DiceFace.DEF)
	#elif test == "Mouvement":
		#owner.G.giveAct(DiceFace.MOV)
