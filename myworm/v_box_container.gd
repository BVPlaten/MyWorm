extends VBoxContainer

@onready var filter_row = $HBoxContainer
@onready var header_row = $HBoxContainer2
@onready var data_container = $VBoxContainer2

var data = [
	{"name": "Max", "age": "29", "city": "Berlin"},
	{"name": "Sophia", "age": "26", "city": "Hamburg"},
	{"name": "Lukas", "age": "34", "city": "München"},
	{"name": "Hannah", "age": "31", "city": "Köln"},
	{"name": "Felix", "age": "27", "city": "Frankfurt"},
	{"name": "Lea", "age": "30", "city": "Stuttgart"},
	{"name": "Jonas", "age": "25", "city": "Düsseldorf"},
	{"name": "Mia", "age": "33", "city": "Dresden"},
	{"name": "Tim", "age": "28", "city": "Leipzig"},
	{"name": "Laura", "age": "32", "city": "Hannover"},
	{"name": "Nico", "age": "24", "city": "Nürnberg"},
	{"name": "Emilia", "age": "36", "city": "Bremen"},
	{"name": "Paul", "age": "29", "city": "Dortmund"},
	{"name": "Lina", "age": "27", "city": "Essen"},
	{"name": "Tobias", "age": "35", "city": "Duisburg"},
	{"name": "Emma", "age": "30", "city": "Bochum"},
	{"name": "Moritz", "age": "31", "city": "Wuppertal"},
	{"name": "Clara", "age": "26", "city": "Bielefeld"},
	{"name": "Sebastian", "age": "34", "city": "Bonn"},
	{"name": "Bernd", "age": "54", "city": "Hückelhoven"},
	{"name": "Helena", "age": "29", "city": "Mannheim"}
]


var filtered_data = []
var sort_column = ""
var sort_ascending = true
var column_names = ["Name", "Age", "City"] # Entspricht den Schlüsseln in deinen Daten

func _ready():
	# Erstelle die Filter-Felder
	for i in range(column_names.size()):
		var filter_edit = LineEdit.new()
		filter_row.add_child(filter_edit)
		filter_edit.connect("text_changed", _on_filter_changed.bind(i))

	# Erstelle die Header-Buttons für die Sortierung
	for i in range(column_names.size()):
		var header_button = Button.new()
		header_button.text = column_names[i]
		header_row.add_child(header_button)
		header_button.connect("pressed", _on_header_clicked.bind(i))

	# Initiales Anzeigen der Daten
	_apply_filters_and_sort()

func _on_filter_changed(new_text: String, column_index: int):
	_apply_filters_and_sort()

func _on_header_clicked(column_index: int):
	var clicked_column = column_names[column_index]
	if sort_column == clicked_column:
		sort_ascending = !sort_ascending
	else:
		sort_column = clicked_column
		sort_ascending = true
	_apply_filters_and_sort()

func _apply_filters_and_sort():
	# 1. Filtern
	filtered_data.clear()
	for item in data:
		var matches_all_filters = true
		for i in range(column_names.size()):
			var filter_text = filter_row.get_child(i).text.to_lower()
			var hilfmir0 = column_names[i].to_lower()
			var hilfmir1 = String(item.get( hilfmir0, ""))
			var hilfmir2 = hilfmir1.to_lower()
			var column_value = String(item.get(column_names[i].to_lower(), "")).to_lower() # Annahme: Schlüssel in Kleinbuchstaben
			if not filter_text.is_empty() and not column_value.contains(filter_text):
				matches_all_filters = false
				break
		if matches_all_filters:
			filtered_data.append(item)

	# 2. Sortieren
	if not sort_column.is_empty():
		filtered_data.sort_custom(func(a, b):
			var value_a = a.get(sort_column.to_lower())
			var value_b = b.get(sort_column.to_lower())
			if typeof(value_a) == TYPE_STRING and typeof(value_b) == TYPE_STRING:
				if sort_ascending:
					return value_a < value_b
				else:
					return value_a > value_b
			else: # Annahme: Numerische oder andere vergleichbare Typen
				if sort_ascending:
					return value_a < value_b
				else:
					return value_a > value_b
		)

	# 3. Daten anzeigen
	_display_data()

func _display_data():
	# Lösche die aktuellen Datenreihen
	for child in data_container.get_children():
		child.queue_free()

	# Zeige die gefilterten und sortierten Daten an
	for i in range(filtered_data.size()):
		var row_data = filtered_data[i]
		var row = HBoxContainer.new()
		row.name = "DataRow_" + str(i)

		# Unterschiedliche Hintergrundfarbe für gerade/ungerade Zeilen
		var background_color = Color(0.9, 0.9, 0.9) if i % 2 == 0 else Color(1.0, 1.0, 1.0)
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = background_color
		row.add_theme_stylebox_override("panel", style_box) # Nutze ein Panel als Hintergrund

		# Füge die Datenzellen hinzu
		for column in column_names:
			var cell_label = Label.new()
			cell_label.text = String(row_data.get(column.to_lower(), ""))
			row.add_child(cell_label)
			cell_label.size_flags_horizontal = Control.SIZE_EXPAND # Nimmt verfügbaren Platz ein

		data_container.add_child(row)
