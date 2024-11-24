extends TextureButton

@export var textArray : Array[Texture]

# 0 -> Texture Attaque
# 1 -> Texture Defense
# 2 -> Texture Mouvement
var normalText : Texture
var using : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textArray.append(load("res://Ressources/Attaque.png"))
	textArray.append(load("res://Ressources/Defense.png"))
	textArray.append(load("res://Ressources/Mouvement.png"))
	normalText = texture_normal
	
	var rand : int = randi() % textArray.size()
	get_child(0).texture = textArray[rand]
	pressed.connect(self._button_pressed)
	var G: Gestionnaire = owner.G
	G.connect("S", Callable(self, "_disabling"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _button_pressed():
	if !using:
		owner.G.giveAct(textArray.find(get_child(0).texture))
		texture_normal = texture_pressed
		using = true
	else:
		owner.G.listAct.erase(textArray.find(get_child(0).texture))
		owner.G.interpretAction()
		texture_normal = normalText
		using = false
	pass
	#if test == "Attaque":
		#owner.G.giveAct(DiceFace.ATK)
	#elif test == "Défense":
		#owner.G.giveAct(DiceFace.DEF)
	#elif test == "Mouvement":
		#owner.G.giveAct(DiceFace.MOV)
func _disabling():
	if using:
		disabled = true
		using = false
