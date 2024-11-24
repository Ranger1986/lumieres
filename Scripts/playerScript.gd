class_name Player
extends Entity

@export var G : Gestionnaire
@export var startingPos : Vector2i = Vector2i(0,0)
static var player : Player
var audio : Array


func _ready():
	super._ready()
	if player == null or !is_instance_valid(player):
		player = self
		ToCellPos(startingPos)
	audio.append(load("res://Ressources/Sounds/Player_hurt1.ogg"))
	audio.append(load("res://Ressources/Sounds/Player_hurt2.ogg"))
	audio.append(load("res://Ressources/Sounds/Player_hurt3.ogg"))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func damaged(dmg:int):
	var audioStreamPlayer2D : Array = self.find_children("", "AudioStreamPlayer2D")
	var rand : int = randi() % 3
	audioStreamPlayer2D[0].stream = audio[rand]
	audioStreamPlayer2D[0].playing = true
	super.damaged(dmg)

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
