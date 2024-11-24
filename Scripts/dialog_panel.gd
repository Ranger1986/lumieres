class_name BoiteDeDialogue
extends Panel

@export var label: Label
@export var btn: Button

# Devra peut-être être mis à "off" au départ si le panneau apparâit trop tôt.
# Il faudra alors l'activer au changement de scène (Menu -> Jeu).
var dialogState: String = "tuto"

func _ready() -> void:
	# Mise en pause du jeu quand le Pannel apparaît
	self.get_parent().get_tree().paused = true

	# Propriétés variables du Panel
	var parent_size: Vector2 = self.get_viewport_rect().size
	var panel_size: Vector2 = 3 * parent_size / 5
	self.size = panel_size

	var parent_center: Vector2 = parent_size / 2
	var panel_center: Vector2 = panel_size / 2
	self.position = parent_center - panel_center

	# Bouton
	btn.size = Vector2(btn.get_parent().size.x, 40)
	btn.position.y = self.size.y
	btn.text = "Suivant"
	btn.pressed.connect(dialogNext)

	# Texte
	label.size = label.get_parent().size
	label.position.y += 300

	var s: String = dialog(dialogState)
	label.set_text(s)

func _process(delta: float) -> void:
	pass

# Que faire quand j'appuie sur le bouton "Suivant"
func dialogNext() -> void:
	if dialogState == "tuto":
		dialogState = "good"

	elif dialogState == "good":
		dialogState = "bad"

	elif dialogState == "bad":
		dialogState = "off"
		self.get_parent().get_tree().paused = false
		self.hide()
	
	var s: String = dialog(dialogState)
	label.set_text(s)

# Retourne le dialogue associé à l'ID en paramètre
func dialog(id: String) -> String:
	var dialogue: String

	var s: String
	match id:
		"tuto":
			s = "res://Ressources/tutorialDialog.txt"
			dialogue = get_text(s)
		"good":
			s = "res://Ressources/goodDialog.txt"
			dialogue = get_random_line(s)
		"bad":
			s = "res://Ressources/badDialog.txt"
			dialogue = get_random_line(s)
		_:
			s = ""
	
	return dialogue

# Retourne une certaine ligne d'un fichier
func get_random_line(path: String) -> String:
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	
	var content: Array[String] = []
	var index = 0
	while not file.eof_reached():
		var line = file.get_line()
		content.append(line)
		index += 1

	var dialogue: String
	var i = randi_range(0, index-1)
	dialogue = content[i]
	
	file.close()
	return dialogue

# Retourne tout le texte d'un fichier
func get_text(path: String) -> String:
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	var dialogue: String = file.get_as_text()
	return dialogue
