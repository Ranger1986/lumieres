class_name Entity
extends Node2D

var map : TileMapLayer

@export var defence : int = 5
var armure : int = 0
@export var force : int = 10
@export var forceVar : int = 5
@export var critrate : float = 0.01
@export var _PVmax : int = 40
var PV : int = _PVmax
var audioDeath

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (owner != null):
		map = owner.find_child("Grid")
		scale *= map.tile_set.tile_size.x / self.texture.get_size().x
	self.offset = self.texture.get_size()/2
	audioDeath = load("res://Ressources/Sounds/Enemy_death.ogg")
	pass # Replace with function body.

func _process(delta: float) -> void:
	#if PV == 0:
		#var audioStreamPlayer2D : Array = self.find_children("", "AudioStreamPlayer2D")
		#audioStreamPlayer2D[0].stream = audioDeath
		#audioStreamPlayer2D[0].playing = true
	pass
	
func cellPos()->Vector2i:
	return position/map.tile_set.tile_size.x
func ToCellPos(pos : Vector2i)-> void:
	position = pos * 64
	
func damaged(dmg:int):
	if dmg < armure:
		armure -= dmg
		return
	dmg-=armure
	armure=0
	PV-=dmg
	if PV <=0:
		death()

func death():
	queue_free()
	
func attack(opp : Entity)->void:
	var dmg : int = force + randi() % 5
	if randi() % 100 < 1:
		dmg*=2
	opp.damaged(dmg)
	
func getNeighbourCells():
	return [
		cellPos() + Vector2i(-1,0),
		cellPos() + Vector2i(0,-1),
		cellPos() + Vector2i(1,0),
		cellPos() + Vector2i(0,1)
	]
	
