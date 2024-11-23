class_name Enemy

extends Sprite2D

@export var G : Gestionnaire

var map : TileMapLayer
var finTour : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Mettre l'ennemi dans la liste du gestionnaire
	G=owner
	G.listeEnemy.append(self)
	G.tailleListeEnemy += 1
	
	map = owner.find_child("Grid")
	scale *= map.tile_set.tile_size.x / texture.get_size().x
	offset = texture.get_size()/2
	
	finTour = false
	
	# Placer ennemi
	position = Vector2(5,5) * 64
	
	pass # Replace with function body.
	
#Déplace l'ennemi d'une case
func _deplacement() -> void:
	var random : int
	random = randi() % 4 # Random entre 0 et 3
	match random:
		0:
			position += Vector2(1,0) * 64
		1:
			position += Vector2(-1,0) * 64
		2:
			position += Vector2(0,1) * 64
		3:
			position += Vector2(0,-1) * 64
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
