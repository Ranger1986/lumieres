class_name Player
extends Entity

@export var G : Gestionnaire
@export var startingPos : Vector2i = Vector2i(0,0)
static var player : Player

func _ready():
	super._ready()
	if player == null or !is_instance_valid(player):
		player = self
		ToCellPos(startingPos)

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
	
func death():
	BoiteDeDialogue.dialogState = "tuto"
	Gestionnaire.progress = 1
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	queue_free()
