class_name Gestionnaire
extends Node
var listAct : Array
var player : Player
var playerHover : Player
var grid : GridInteractive
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	listAct = []
	player = find_child("PlayerSprite")
	playerHover = player.duplicate()
	self.add_child(playerHover)
	playerHover.modulate.a=0.5
	grid = find_child("GridInteractive")
	pass # Replace with function body.


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
	
