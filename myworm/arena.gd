extends Node2D

var movespeed = 500.0 # Geschwindigkeit der Bewegung in Pixel pro Sekunde
var player: Sprite2D

func _ready():
	# Pfad zur Szene-Datei deines Sprites
	var szene_pfad = "res://worm_part.tscn" # Ersetze dies durch den tatsächlichen Pfad, falls er anders ist

	# Szene laden
	var geladene_szene = ResourceLoader.load(szene_pfad)

	# Überprüfen, ob die Szene erfolgreich geladen wurde
	if geladene_szene:
		# Eine Instanz der geladenen Szene erstellen
		player = geladene_szene.instantiate() as Sprite2D

		# Überprüfen, ob die Instanz erfolgreich erstellt wurde und vom Typ Sprite2D ist
		if player:
			# Der Instanz einen Namen geben (optional)
			player.name = "MeinBeweglichesSprite"

			add_child(player)

			var screen_size = get_viewport().size
			player.position = screen_size / 2
		else:
			printerr("Fehler: Die instanziierte Szene ist kein Sprite2D.")
	else:
		printerr("Fehler beim Laden der Szene: ", szene_pfad)

func _physics_process(delta):
	if player:
		var direction = Vector2.ZERO

		# Horizontale Bewegung prüfen
		if Input.is_action_pressed("ui_left"):
			direction.x = -1
		elif Input.is_action_pressed("ui_right"):
			direction.x = 1

		# Wenn keine horizontale Bewegung, dann vertikale Bewegung prüfen
		elif Input.is_action_pressed("ui_up"):
			direction.y = -1
		elif Input.is_action_pressed("ui_down"):
			direction.y = 1

		# Bewegung anwenden (keine Normalisierung mehr nötig, da nur eine Achse bewegt wird)
		player.position += direction * movespeed * delta
