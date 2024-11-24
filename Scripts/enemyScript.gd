class_name Enemy
extends Entity

@export var G : Gestionnaire

var finTour : bool
signal loot()
func _ready() -> void:
	PV=1
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
	if getNeighbourCells().any(func(a:Vector2i):return a == Player.player.cellPos()):
		attack(G.player)
	var direction :Vector2i = Player.player.cellPos() - cellPos()
	if abs(direction.x) > abs(direction.y) :
		ejected(Vector2i(1,0)*sign(direction.x))
	else:
		ejected(Vector2i(0,1)*sign(direction.y))
		
	
	#var postmp : Vector2
	#
	#postmp = deplacementRandom()
	#
	#while postmp.x > (G.longueurPlateau - 1) * 64 or postmp.x < 0 or postmp.y > (G.largeurPlateau - 1) *64 or postmp.y < 0:
		#postmp = deplacementRandom()
	#
	#position = postmp
	
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func damaged(dmg:int):
	#PV-=dmg
	#if PV <=0:
		#G.listeEnemy.pop_at(G.listeEnemy.find(self))
		#queue_free()
func ejected(dir : Vector2i, nbcase : int = 1):
	for i in range(nbcase):
		if G.getEnemy(cellPos()+dir) == -1 and cellPos()+dir != Player.player.cellPos():
			ToCellPos(cellPos()+dir)
func death():
	emit_signal("loot")
	G.listeEnemy.pop_at(G.listeEnemy.find(self))
	super.death()
