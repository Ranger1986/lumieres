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

var nextpos : Vector2i

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
		nextpos = pos
		playerHover.show()
	elif(grid.get_cell_source_id(pos)==1 and listeEnemy.filter(func(a:Enemy): return a.cellPos() == pos).size()!=0):
		var cells : Array = grid.markedCells.duplicate()
		cells.sort_custom(func(a,b): return grid.get_cell_source_id(a)==0 and (a - pos).length() < (b-pos).length())
		if grid.get_cell_source_id(cells[0])==0:
			playerHover.ToCellPos(cells[0])
			nextpos = cells[0]
			playerHover.show()
	else:
		nextpos= Vector2i(-1,-1)
		playerHover.hide()
	pass

func giveAct(diceFace: int ):
	listAct.append(diceFace)
	interpretAction()
	
func interpretAction():
	grid.cleanCells()
	listAct.sort()
	print(listAct)
	var nbatk : int = listAct.count(0)
	var nbdef : int = listAct.count(1)
	var nbmov : int = listAct.count(2)
	print("nbatk=",nbatk)
	print("nbdef=",nbdef)
	print("nbmov=",nbmov)
	if nbmov == listAct.size():
		for i in range(-nbmov, nbmov+1):
			for j in range(-nbmov, nbmov+1):
				if ((abs(i)+abs(j))<=nbmov):
					grid.markCells([player.cellPos()+Vector2i(i,j)],0)
	elif nbatk == listAct.size():
		grid.markCells([player.cellPos()+Vector2i(1,0),
			player.cellPos()+Vector2i(0,1),
			player.cellPos()+Vector2i(-1,0),
			player.cellPos()+Vector2i(0,-1)], 1)
	elif nbdef == listAct.size():
		pass
					
	elif nbmov+nbdef == listAct.size():
		for i in range(-nbmov, nbmov+1):
			grid.markCells([player.cellPos()+Vector2i(i,0)],0)
			grid.markCells([player.cellPos()+Vector2i(0,i)],0)
			
	elif nbmov+nbatk == listAct.size():
		for i in range(-nbmov-1, nbmov+1+1):
			for j in range(-nbmov-1, nbmov+1+1):
				if i in range(-nbmov, nbmov+1) and j in range(-nbmov, nbmov+1) and ((abs(i)+abs(j))<=nbmov):
					grid.markCells([player.cellPos()+Vector2i(i,j)],0)
				elif ((abs(i)+abs(j))<=nbmov+2): 
					grid.markCells([player.cellPos()+Vector2i(i,j)],1)
	elif nbdef+nbatk == listAct.size():
		grid.markCells([player.cellPos()+Vector2i(1,0),
			player.cellPos()+Vector2i(0,1),
			player.cellPos()+Vector2i(-1,0),
			player.cellPos()+Vector2i(0,-1)], 1)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var pos : Vector2i = floor(event.position/64)
		if(nextpos!=null and nextpos!=Vector2i(-1,-1)):
			if (listAct.count(1)==0 and listeEnemy.filter(func(a:Enemy): return a.cellPos() != nextpos).size()!=0):
				player.ToCellPos(nextpos)
				grid.cleanCells()
				listAct=[]
			elif(listAct.count(1)!=0):
				listeEnemy[0].ToCellPos(listeEnemy[0].cellPos() + Vector2i((nextpos - player.cellPos())/(nextpos - player.cellPos()).length()*listAct.count(1)))
				player.ToCellPos(nextpos)
				grid.cleanCells()
				listAct=[]
		if (listeEnemy.filter(func(a:Enemy): return a.cellPos() == pos).size()!=0 and grid.get_cell_source_id(pos)==1):
			if(listAct.count(1)!=0):
				listeEnemy[0].ToCellPos(listeEnemy[0].cellPos() + Vector2i((pos - player.cellPos())/(pos - player.cellPos()).length()*listAct.count(1)))
				grid.cleanCells()
				listAct=[]
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_ESCAPE:
		listAct.pop_back()
		interpretAction()
	
