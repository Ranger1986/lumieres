class_name Gestionnaire
extends Node
var listAct : Array
var player : Player
var playerHover : Player
var grid : GridInteractive

var largeurPlateau : int = 10
var longueurPlateau : int = 12
# Called when the node enters the scene tree for the first time.
var tour : int
var listeEnemy : Array
var tailleListeEnemy : int
var nbEnemy : int = 4
@export var enemy: PackedScene

func _ready() -> void:
	listAct = []
	player = find_child("PlayerSprite")
	playerHover = player.duplicate()
	self.add_child(playerHover)
	playerHover.modulate.a=0.5
	grid = find_child("GridInteractive")
	largeurPlateau = 10
	longueurPlateau = 12
	tour = 0
	
	_ajoutEnemy(nbEnemy)
	
	pass # Replace with function body.

func _ajoutEnemy(nbEnemy : int) -> void:
	for i in nbEnemy:
		var nodeEnemy = enemy.instantiate()
		add_child(nodeEnemy)
		nodeEnemy.G = self
		nodeEnemy.map = grid
		nodeEnemy.position = Vector2(randi() % (longueurPlateau), randi() % (largeurPlateau)) * 64
		nodeEnemy.scale *= nodeEnemy.map.tile_set.tile_size.x / nodeEnemy.texture.get_size().x
		nodeEnemy.offset = nodeEnemy.texture.get_size()/2
		
		listeEnemy.append(nodeEnemy)
		tailleListeEnemy += 1
	pass

func _actionsEnemy() -> void:
	for n in tailleListeEnemy:
		listeEnemy[n]._deplacement()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var pos :Vector2i = floor(get_viewport().get_mouse_position()/64)
	if(grid.get_cell_source_id(pos)==0):
		playerHover.ToCellPos(pos)
		playerHover.show()
	else:
		playerHover.hide()
	pass

func giveAct(diceFace: int ):
	grid.cleanCells()
	listAct.append(diceFace)
	print(listAct)
	match diceFace:
		DiceFace.ATK:
			grid.markCells([player.cellPos()+Vector2i(1,0),
				player.cellPos()+Vector2i(0,1),
				player.cellPos()+Vector2i(-1,0),
				player.cellPos()+Vector2i(0,-1)], 1)
		DiceFace.MOV:
			grid.markCells([player.cellPos()+Vector2i(1,0),
				player.cellPos()+Vector2i(0,1),
				player.cellPos()+Vector2i(-1,0),
				player.cellPos()+Vector2i(0,-1)], 0)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var pos : Vector2i = floor(event.position/64)
		if(grid.get_cell_source_id(pos)==0):
			player.ToCellPos(pos)
			grid.cleanCells()
	
