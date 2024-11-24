class_name Dice
extends TextureButton

@export var textArray : Array[Texture]

# 0 -> Texture Attaque
# 1 -> Texture Defense
# 2 -> Texture Mouvement
var normalText : Texture
var using : bool = false
var num : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#textArray.append(load("res://Ressources/Attaque.png"))
	#textArray.append(load("res://Ressources/Defense.png"))
	#textArray.append(load("res://Ressources/Mouvement.png"))
	if normalText == null:
		normalText = texture_normal
	
	var rand : int = randi() % textArray.size()
	get_child(0).texture = textArray[rand]
	pressed.connect(self._button_pressed)
	if owner != null:
		_connect()
	pass # Replace with function body.

func _connect():
	var G: Gestionnaire = owner.G
	G.connect("S", Callable(self, "_disabling"))
	num = G.find_children("", "Dice").find(self)+1
	get_child(1).text = str(num)
	
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
func clean():
	texture_normal = normalText
	using = false
	disabled = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_released() :
		if event.as_text_key_label()==str(num) and !disabled:
			_button_pressed()
		#var e : InputEventKey = event
		#print(e.as_text_key_label())
