extends Node2D

var movespeed = 500.0 # Geschwindigkeit der Bewegung in Pixel pro Sekunde
var player: Sprite2D
enum dirctn {  ZERO, NORDEN,  SUEDEN,  OSTEN,  WESTEN }
var current_drctn = dirctn.ZERO

func _ready():
	# Szene laden
	var pfad = "res://worm_part.tscn"
	var geladene_szene = ResourceLoader.load(pfad)

	# Überprüfen, ob die Szene erfolgreich geladen wurde
	if geladene_szene:
		player = geladene_szene.instantiate() as Sprite2D  # Eine Instanz der geladenen Szene erstellen

		# Überprüfen, ob die Instanz erfolgreich erstellt wurde und vom Typ Sprite2D ist
		if player:
			player.name = "WormPart"
			add_child(player)
			var screen_size = get_viewport().size
			player.position = screen_size / 2
		else:
			printerr("Fehler: Die instanziierte Szene ist kein Sprite2D.")
	else:
		printerr("Fehler beim Laden der Szene: ", pfad)

func _physics_process(delta):
	if player:
		# richtung der cursortasten zwischenspeichern
		if Input.is_action_pressed("ui_left"):
			current_drctn = dirctn.WESTEN
		elif Input.is_action_pressed("ui_right"):
			current_drctn = dirctn.OSTEN
		elif Input.is_action_pressed("ui_up"):
			current_drctn = dirctn.NORDEN
		elif Input.is_action_pressed("ui_down"):
			current_drctn = dirctn.SUEDEN

		# derzeitige bewegung ausführen
		var direction = Vector2.ZERO
		if current_drctn == dirctn.WESTEN:
			direction.x = -1
		elif current_drctn == dirctn.OSTEN:
			direction.x = 1
		elif current_drctn == dirctn.NORDEN:
			direction.y = -1
		elif current_drctn == dirctn.SUEDEN:
			direction.y = 1
		elif current_drctn == dirctn.ZERO:
			var screen_size = get_viewport().size
			player.position = screen_size / 2

		player.position += direction * movespeed * delta
