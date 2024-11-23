class_name Enemy

extends Sprite2D

@export var G : Gestionnaire
@export var _PVmax : int = 40
var PV : int

var map : TileMapLayer
var finTour : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PV=_PVmax
	pass # Replace with function body.

func deplacementRandom() -> Vector2:
	var random : int
	random = randi() % 4 # Random entre 0 et 3
	
	var pos : Vector2
	
	match random:
		0:
			pos = position + Vector2(1,0) * 64
		1:
			pos = position + Vector2(-1,0) * 64
		2:
			pos = position + Vector2(0,1) * 64
		3:
			pos = position + Vector2(0,-1) * 64
	
	return pos

#Déplace l'ennemi d'une case
func _deplacement() -> void:
	var postmp : Vector2
	
	postmp = deplacementRandom()
	
	while postmp.x > (G.longueurPlateau - 1) * 64 or postmp.x < 0 or postmp.y > (G.largeurPlateau - 1) *64 or postmp.y < 0:
		postmp = deplacementRandom()
	
	position = postmp
	
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func cellPos()->Vector2i:
	return position/map.tile_set.tile_size.x
func ToCellPos(pos : Vector2i)-> void:
	position = pos * 64
	
