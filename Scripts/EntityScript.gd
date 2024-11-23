class_name Entity
extends Node2D

var map : TileMapLayer

@export var force : int = 10
@export var forceVar : int = 5
@export var critrate : float = 0.01
@export var _PVmax : int = 40
var PV : int = _PVmax

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (owner != null):
		map = owner.find_child("Grid")
		scale *= map.tile_set.tile_size.x / self.texture.get_size().x
	self.offset = self.texture.get_size()/2
	pass # Replace with function body.

	
func cellPos()->Vector2i:
	return position/map.tile_set.tile_size.x
func ToCellPos(pos : Vector2i)-> void:
	position = pos * 64
func damaged(dmg:int):
	PV-=dmg
	if PV <=0:
		queue_free()
func attack(opp : Entity)->void:
	var dmg : int = force + randi() % 5
	if randi() % 100 < 1:
		dmg*=2
	opp.damaged(dmg)
