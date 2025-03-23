extends Sprite2D

func _draw():
	var rect_position = Vector2(0, 0)
	var rect_size = Vector2(24, 24)
	var rect = Rect2(rect_position, rect_size)
	var red_color = Color(1, 0, 0) # RGB: 1.0 for red, 0.0 for green and blue
	var border_thickness = 3.0 # Die gewünschte Dicke des Randes
	draw_rect(rect, red_color, false, border_thickness) # 'false' für nicht gefüllt, und border_thickness für die Linienbreite
