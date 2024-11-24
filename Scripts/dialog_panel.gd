class_name BoiteDeDialogue
extends Panel

@export var SuzanneStatic: ColorRect
@export var Suzanne: Sprite2D

# Devra peut-être être mis à "off" au départ si le panneau apparâit trop tôt.
# Il faudra alors l'activer au changement de scène (Menu -> Jeu).
static var dialogState: String = "tuto"
@export var label: Label
@export var btn: Button

func _ready() -> void:
	# Mise en pause du jeu quand le Pannel apparaît
	self.get_parent().get_tree().paused = true

	# Cacher l'image de Suzanne présente dans le menu à gauche
	SuzanneStatic.hide_suzanne()

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
	label.position.y += 250

	var s: String = dialog(dialogState)
	label.set_text(s)

	# Image
	Suzanne.scale = Vector2(0.8, 0.8)
	Suzanne.position = Vector2(panel_center.x, 100)

func _process(delta: float) -> void:
	pass

# Que faire quand j'appuie sur le bouton "Suivant"
func dialogNext() -> void:
	dialogState = "off"
	self.get_parent().get_tree().paused = false
	self.hide()
	SuzanneStatic.show_suzanne()
	
	var s: String = dialog(dialogState)
	label.set_text(s)

# Retourne le dialogue associé à l'ID en paramètre
func dialog(id: String) -> String:
	var dialogue: String

	var s: String
	match id:
		"tuto":
			#s = "res://Ressources/tutorialDialog.txt"
			#var file = FileAccess.open("res://Ressources/tutorialDialog.txt", FileAccess.READ)
			#var content = file.get_as_text()
			##print(content)
			dialogue = "Salut tête de crâne !
J’ignore d’où tu viens, mais joins-toi à moi. Je suis Suzanne. Laisse-moi t'expliquer comment cet endroit fonctionne. Tout se base sur les dés que tu possèdes. Ils sont affichés à droite.
En lançant les dés, tu as accès à des actions, pour te déplacer dans le donjon, attaquer les monstres, ou te défendre. En sélectionnant plusieurs dés, tu peux effectuer des combinaisons. Utilise-les avec intelligence !
En éliminant un monstre, on obtient le dé qu'il contient... Mais évitons de les tuer. S'ils s'approchent assez de moi, je peux les capturer, sans les tuer. 
Priorise la capture, d'accord ?

Avançons... La sortie ne doit pas être loin..." #get_text(s)
		"Level_2":
			#s = "res://Ressources/goodDialog.txt"
			dialogue = "Suzanne est fière de toi !"
		"Level_3":
			# BOSS
			#s = "res://Ressources/badDialog.txt"
			dialogue = "Merci beaucoup pour ton aide, tête de crâne !
Je me souviendrais de toi, ne t'en fais pas. Tu m'aura été très utile, mais je n'ai plus besoin de toi. Prépare-toi à périr !"
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
