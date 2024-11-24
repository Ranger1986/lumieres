class_name Gestionnaire
extends Node
var listAct : Array[int]
var player : Player
var playerHover : Player
var grid : GridInteractive
static var offset : Vector2
var largeurPlateau : int = 10
var longueurPlateau : int = 12
# Called when the node enters the scene tree for the first time.
var tour : int
var listeEnemy : Array[Enemy]
static var nbEnemy : int = 4
@export var enemy: PackedScene
var nextpos : Vector2i

signal S()

func _ready() -> void:
	listAct = []
	player = find_child("PlayerSprite")
	playerHover = player.duplicate()
	find_child("Carte").add_child(playerHover)
	playerHover.modulate.a=0.5
	grid = find_child("GridInteractive")
	largeurPlateau = 10
	longueurPlateau = 12
	tour = 0
	
	_ajoutEnemy(nbEnemy)
	for enemy in listeEnemy:
		enemy.connect("loot", Callable(find_child("DiceMenu"), "_addDice"))
	find_child("Carte").position.x = find_child("SuzanneMenu").size.x
	var tileMap : TileMapLayer = find_child("Map")
	offset=Vector2(find_child("SuzanneMenu").size.x,0)
	var cells: Array[Vector2i] = []
	for i in range(int((find_child("DiceMenu").position.x-find_child("SuzanneMenu").size.x)/grid.tile_set.tile_size.x)*4):
		for j in range(get_viewport().size.y/tileMap.tile_set.tile_size.y):
			cells.append(Vector2i(i,j))
	tileMap.set_cells_terrain_connect(cells, 0, 0)
	
	tileMap = find_child("Grid")
	cells = []
	for i in range(int((find_child("DiceMenu").position.x-find_child("SuzanneMenu").size.x)/grid.tile_set.tile_size.x)):
		for j in range(get_viewport().size.y/tileMap.tile_set.tile_size.y):
			tileMap.set_cell(Vector2i(i,j),0,Vector2i(0,0)) 
			grid.maxTile=Vector2i(i,j)
	
	_showCapturables()
	pass # Replace with function body.

func _ajoutEnemy(nbEnemy : int) -> void:
	for i in nbEnemy:
		var nodeEnemy = enemy.instantiate()
		find_child("Carte").add_child(nodeEnemy)
		nodeEnemy.G = self
		nodeEnemy.map = grid
		nodeEnemy.position = Vector2(randi() % (longueurPlateau), randi() % (largeurPlateau)) * 64 + offset
		nodeEnemy.scale *= nodeEnemy.map.tile_set.tile_size.x / nodeEnemy.texture.get_size().x
		nodeEnemy.offset = nodeEnemy.texture.get_size()/2
		
		listeEnemy.append(nodeEnemy)
	pass

func _actionsEnemy() -> void:
	grid.cleanCaptureCells()
	for n in listeEnemy.size():
		listeEnemy[n]._deplacement()
	_showCapturables()
	pass
	
func getEnemy(pos :Vector2i)->int:
	var enemies :Array = listeEnemy.filter(func(a:Enemy): return a.cellPos() == pos)
	if enemies.size() ==0:
		return -1
	return listeEnemy.find(enemies[0])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Suzanne.suzanneMode:
		return
	var pos :Vector2i = floor((get_viewport().get_mouse_position()-offset)/64)
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
	
	if listeEnemy.size()==0:
		nbEnemy+=4
		get_tree().change_scene_to_file("res://Scenes/FirstLevel.tscn")

func giveAct(diceFace: int ):
	listAct.append(diceFace)
	interpretAction()
	
func interpretAction():
	grid.cleanCells()
	listAct.sort()
	#print(listAct)
	var nbatk : int = listAct.count(0)
	var nbdef : int = listAct.count(1)
	var nbmov : int = listAct.count(2)
	#print("offset=",offset)
	#print("nbatk=",nbatk)
	#print("nbdef=",nbdef)
	#print("nbmov=",nbmov)
	if nbmov == listAct.size():
		for i in range(-nbmov, nbmov+1):
			for j in range(-nbmov, nbmov+1):
				if ((abs(i)+abs(j))<=nbmov 
					and getEnemy(player.cellPos()+Vector2i(i,j))==-1):
					grid.markCells([player.cellPos()+Vector2i(i,j)],0)
	elif nbatk == listAct.size():
		grid.markCells([player.cellPos()+Vector2i(1,0),
			player.cellPos()+Vector2i(0,1),
			player.cellPos()+Vector2i(-1,0),
			player.cellPos()+Vector2i(0,-1)], 1)
	elif nbdef == listAct.size():
		grid.markCells([player.cellPos()],2)
					
	elif nbmov+nbdef == listAct.size():
		for i in range(-nbmov, nbmov+1):
			grid.markCells([player.cellPos()+Vector2i(i,0)],0)
			grid.markCells([player.cellPos()+Vector2i(0,i)],0)
			
	elif nbmov+nbatk == listAct.size():
		for i in range(-nbmov-1, nbmov+1+1):
			for j in range(-nbmov-1, nbmov+1+1):
				if i in range(-nbmov, nbmov+1) and j in range(-nbmov, nbmov+1) and ((abs(i)+abs(j))<=nbmov):
					if (getEnemy(player.cellPos()+Vector2i(i,j))==-1):
						grid.markCells([player.cellPos()+Vector2i(i,j)],0)
					else:
						grid.markCells([player.cellPos()+Vector2i(i,j)],1)
				elif ((abs(i)+abs(j))<=nbmov+2): 
					grid.markCells([player.cellPos()+Vector2i(i,j)],1)
				
	elif nbdef+nbatk == listAct.size():
		grid.markCells([player.cellPos()+Vector2i(1,0),
			player.cellPos()+Vector2i(0,1),
			player.cellPos()+Vector2i(-1,0),
			player.cellPos()+Vector2i(0,-1)], 1)
			
	if nbdef == 0 or nbmov !=0:
		grid.markCells([player.cellPos()],-1)
		
	
func _input(event: InputEvent) -> void:
	if Suzanne.suzanneMode:
		return
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var pos : Vector2i = floor((event.position-offset)/64)
		# Quand il n'y a pas de déplacement
		var acted :bool = false
		if(nextpos!=null and nextpos!=Vector2i(-1,-1)):
			if (getEnemy(nextpos) == -1):
				player.ToCellPos(nextpos)
				acted = true
			elif(listAct.count(DiceFace.DEF)!=0):
				listeEnemy[getEnemy(nextpos)].ejected(Vector2i(pos - player.cellPos())/(pos - player.cellPos()).length(),listAct.count(1))
				#listeEnemy[getEnemy(nextpos)].ToCellPos(listeEnemy[getEnemy(nextpos)].cellPos() + Vector2i((nextpos - player.cellPos())/(nextpos - player.cellPos()).length()*listAct.count(1)))
				player.ToCellPos(nextpos)
				acted = true
		if (getEnemy(pos)!=-1 and grid.get_cell_source_id(pos)==1):
			var en : Enemy = listeEnemy[getEnemy(pos)]
			player.attackD(en,listAct)
			if(listAct.count(DiceFace.DEF)!=0 and is_instance_valid(en)):
				en.ejected(Vector2i(pos - player.cellPos())/(pos - player.cellPos()).length(),listAct.count(1))
			acted = true
		if (pos == player.cellPos() and grid.get_cell_source_id(pos)==2):
			player.defenceD(listAct)
			acted = true
			
		
		if acted:
			emit_signal("S")
			grid.cleanCells()
			listAct=[]
			grid.cleanCaptureCells()
			_showCapturables()

func _showCapturables():
	grid.cleanCaptureCells()
	for en :Enemy in listeEnemy:
		if en.PV < en.seuilPV:
			grid.markCaptureCells([en.cellPos()],3)
