class_name Suzanne
extends Entity

static var suzanne :Suzanne
static var suzanneMode :bool= false
static var suzanneturn :bool= true

func _input(event: InputEvent) -> void:
	if !suzanneturn:
		return
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var grid : GridInteractive= owner.find_child("GridInteractive")
		var pos : Vector2i = floor((event.position-Gestionnaire.offset)/64)
		if pos == cellPos():
			suzanneMode = true
			for i in range(-2, 3):
				for j in range(-2, 3):
					if ((abs(i)+abs(j))<=2 
						and owner.getEnemy(cellPos()+Vector2i(i,j))==-1):
						grid.markCells([cellPos()+Vector2i(i,j)],0)
		elif suzanneMode and grid.get_cell_source_id(pos)==0:
			ToCellPos(pos)
			grid.cleanCells()
			suzanneMode = false
			suzanneturn = false
		else:
			grid.cleanCells()
