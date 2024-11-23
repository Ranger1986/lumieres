class_name Enemy
extends Entity

@export var G : Gestionnaire

var finTour : bool


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

func damaged(dmg:int):
	PV-=dmg
	if PV <=0:
		G.listeEnemy.pop_at(G.listeEnemy.find(self))
		queue_free()
