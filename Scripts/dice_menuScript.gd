extends ColorRect

@export var G : Gestionnaire

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	custom_minimum_size=Vector2i(get_viewport_rect().size.x - self.size.x, get_viewport_rect().size.y)  # indépendant de la taille du rect 
	position=Vector2i(get_viewport_rect().size.x - self.size.x, 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(Player.player):
		find_child("PVlabel").text = "PV: " + str(Player.player.PV) + "/" + str(Player.player._PVmax)
		find_child("ArmureLabel").text = "Armure: " + str(Player.player.armure)
	pass
func _addDice():
	if find_child("DiceContainer").get_child_count()<9:
		var instance : Dice = find_child("DiceContainer").get_child(0).duplicate()
		find_child("DiceContainer").add_child(instance)
		instance.owner = self
		instance.disabled = true
		instance._connect()
	
