extends Node2D

var player: Sprite2D
var current_drctn: GlobalEnums.dirctn

func _ready():
	# Szene laden
	var pfad = "res://worm_part.tscn"
	var geladene_szene = ResourceLoader.load(pfad)

	if geladene_szene:
		player = geladene_szene.instantiate() as Sprite2D

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
		if Input.is_action_pressed("ui_left"):
			current_drctn = GlobalEnums.dirctn.WESTEN
		elif Input.is_action_pressed("ui_right"):
			current_drctn = GlobalEnums.dirctn.OSTEN
		elif Input.is_action_pressed("ui_up"):
			current_drctn = GlobalEnums.dirctn.NORDEN
		elif Input.is_action_pressed("ui_down"):
			current_drctn = GlobalEnums.dirctn.SUEDEN
		elif Input.is_action_pressed("ui_accept"):
			current_drctn = GlobalEnums.dirctn.ZERO
	player.move_in_direction(current_drctn,delta)
