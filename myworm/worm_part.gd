extends Sprite2D

var movespeed = 600.0 # Geschwindigkeit der Bewegung in Pixel pro Sekunde

#var current_drctn = GlobalEnums.dirctn.ZERO

func _draw():
	var rect_position = Vector2(0, 0)
	var rect_size = Vector2(12, 12)
	var rect = Rect2(rect_position, rect_size)
	var red_color = Color(0.8, 0.2, 0.2) # RGB: 1.0 for red, 0.0 for green and blue
	var border_thickness = 3.0 # Die gewünschte Dicke des Randes
	draw_rect(rect, red_color, false, border_thickness) # 'false' für nicht gefüllt, und border_thickness für die Linienbreite

func move_in_direction(dirctnId :GlobalEnums.dirctn, delta):
		var direction = Vector2.ZERO
		
		if dirctnId == GlobalEnums.dirctn.WESTEN:
			direction.x = -1
		elif dirctnId == GlobalEnums.dirctn.OSTEN:
			direction.x = 1
		elif dirctnId == GlobalEnums.dirctn.NORDEN:
			direction.y = -1
		elif dirctnId == GlobalEnums.dirctn.SUEDEN:
			direction.y = 1
		elif dirctnId == GlobalEnums.dirctn.ZERO:
			var screen_size = get_viewport().size
			position = screen_size / 2

		position += direction * movespeed * delta
