class_name Suzanne
extends Entity

static var suzanne :Suzanne
static var suzanneMode :bool= false
static var suzanneturn :bool= true
var original_color : Color
@export var startingPos : Vector2i = Vector2i(0,0)

var audioCapture : Array = []
func _ready() -> void:
	super._ready()
	if suzanne == null:
		suzanne = self
		ToCellPos(startingPos)
	original_color = modulate
	
	audioCapture.append(load("res://Ressources/Sounds/Capture1.ogg"))
	audioCapture.append(load("res://Ressources/Sounds/Capture2.ogg"))
	audioCapture.append(load("res://Ressources/Sounds/Capture3.ogg"))
	
#func _process(delta: float) -> void:
	#var grid : GridInteractive= owner.find_child("GridInteractive")
	#var pos :Vector2i = floor((get_viewport().get_mouse_position()-Gestionnaire.offset)/64)
	#if(grid.get_cell_source_id(pos)==0 and suzanneMode):
		#get_child(0).position = Vector2(pos)*64+Gestionnaire.offset
		#pass
	
func _input(event: InputEvent) -> void:
	if !suzanneturn:
		return
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var grid : GridInteractive= owner.find_child("GridInteractive")
		var pos : Vector2i = floor((event.position-Gestionnaire.offset)/64)
		if pos == cellPos():
			grid.cleanCells()
			suzanneMode = true
			for i in range(-2, 3):
				for j in range(-2, 3):
					if ((abs(i)+abs(j))<=2 
						and owner.getEnemy(cellPos()+Vector2i(i,j))==-1):
						grid.markCells([cellPos()+Vector2i(i,j)],0)
			grid.markCells([Player.player.cellPos()],-1)
			grid.markCells([cellPos()],-1)
		elif suzanneMode and grid.get_cell_source_id(pos)==0:
			ToCellPos(pos)
			grid.cleanCells()
			suzanneMode = false
			suzanneturn = false
			modulate.r=0
			modulate.g=150
			modulate.b=0
		elif suzanneMode and grid.get_cell_source_id(pos)==3 and (cellPos()-pos).length()<=3:
			print("NOMNOM")
			
			var G : Gestionnaire = owner
			
			var audioStreamPlayer2D : Array = self.find_children("", "AudioStreamPlayer2D")
			var rand : int = randi() % 3
			audioStreamPlayer2D[0].stream = audioCapture[rand]
			audioStreamPlayer2D[0].playing = true
			
			G.listeEnemy[G.getEnemy(pos)].capture()
			grid.markCells([pos],-1)
			grid.cleanCells()
			suzanneMode = false
			suzanneturn = false
			modulate.r=0
			modulate.g=150
			modulate.b=0
		elif suzanneMode:
			suzanneMode = false
			grid.cleanCells()
