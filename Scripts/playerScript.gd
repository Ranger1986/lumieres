class_name Player
extends Entity

@export var G : Gestionnaire




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
			print("crit")
			dmg*=2
		print("dmg = ", dmg)
		dmgTot+=dmg
	opp.damaged(dmgTot)
