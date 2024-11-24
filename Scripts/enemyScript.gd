class_name Enemy
extends Entity

@export var G : Gestionnaire

var finTour : bool
var seuilPV:int =10
var listeTexture : Array
var audio : Array
var audioCapture : Array

signal loot()
signal capturesignal(text:Texture)
#signal capturable(pos:Vector2i)
func _ready() -> void:
	PV=20
	
	listeTexture.append(load("res://Ressources/AnimalDice_Bear.png"))
	listeTexture.append(load("res://Ressources/AnimalDice_Fox.png"))
	listeTexture.append(load("res://Ressources/AnimalDice_Rabbit.png"))
	listeTexture.append(load("res://Ressources/AnimalDice_Owl.png"))
	
	audio.append(load("res://Ressources/Sounds/Attaque1.ogg"))
	audio.append(load("res://Ressources/Sounds/Attaque2.ogg"))
	audio.append(load("res://Ressources/Sounds/Attaque3.ogg"))
	audio.append(load("res://Ressources/Sounds/Attaque4.ogg"))
	
	var rand : int = randi() % listeTexture.size()
	self.texture = listeTexture[rand]
		
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

	if self.PV == 0:
		print("OSKOUR")
		
	pass



func damaged(dmg:int):
	var audioStreamPlayer2D : Array = self.find_children("", "AudioStreamPlayer2D")
	var rand : int = randi() % 4
	audioStreamPlayer2D[0].stream = audio[rand]
	audioStreamPlayer2D[0].playing = true
	super.damaged(dmg)
	pass
	
func ejected(dir : Vector2i, nbcase : int = 1):
	for i in range(nbcase):
		if G.getEnemy(cellPos()+dir) == -1 and cellPos()+dir != Player.player.cellPos():
			ToCellPos(cellPos()+dir)
func death():
	emit_signal("loot")
	G.listeEnemy.pop_at(G.listeEnemy.find(self))
	super.death()
	
func capture():
	emit_signal("capturesignal", self.texture)
	G.listeEnemy.pop_at(G.listeEnemy.find(self))
	super.death()
