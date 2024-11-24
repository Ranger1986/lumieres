class_name Player
extends Entity

@export var G : Gestionnaire
@export var startingPos : Vector2i = Vector2i(0,0)
static var player : Player


func _ready():
	super._ready()
	if player == null:
		player = self
		ToCellPos(startingPos)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func attackD(opp : Entity, listAct : Array[int])->void:
	var atkCount : int = listAct.count(DiceFace.ATK)
	var movCount : int = listAct.count(DiceFace.MOV)
	var dmgTot : int = 0
	for i in range(atkCount):
		var dmg : int = force + atkCount + randi() % 5
		if randi() % 100 < movCount+1:
			dmg*=2
		dmgTot+=dmg
	opp.damaged(dmgTot)

func defenceD(listAct : Array[int])->void:
	armure += (defence + listAct.count(DiceFace.DEF))*listAct.count(DiceFace.DEF)
