class_name GridInteractive
extends TileMapLayer

var markedCells : Array
static var maxTile : Vector2i
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	markedCells=[]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func markCells(cells : Array, atlas: int) -> void:
	for cell : Vector2i in cells:
		if  cellAllowed(cell):
			set_cell(cell,atlas,Vector2i(0,0))
			markedCells.append(cell)
func cleanCells()->void:
	for cell : Vector2i in markedCells:
		set_cell(cell)
	markedCells = []
static func cellAllowed(cell:Vector2i)->bool:
	return cell.x >-1 and cell.y >-1 and cell.x <= maxTile.x and cell.y <= maxTile.y
