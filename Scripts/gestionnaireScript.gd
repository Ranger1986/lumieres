class_name Gestionnaire
extends Node
# Called when the node enters the scene tree for the first time.
var tour : int
var listeEnemy : Array
var tailleListeEnemy : int

func _ready() -> void:
	tour = 0
	tailleListeEnemy = find_children("", "Enemy").size()
	pass # Replace with function body.

func _actionsEnemy() -> void:
	print(tailleListeEnemy)
	for n in tailleListeEnemy:
		listeEnemy[0]._deplacement()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
