extends Control

@onready var search_box = $VBoxContainer/SearchBox
@onready var tree = $VBoxContainer/Tree
@onready var header_container = $VBoxContainer/HeaderButtons  # Neue Container-Referenz für Buttons

var data = [
	["ID", "Name", "Alter"],
	["1", "Alice", "25"],
	["2", "Bob", "30"],
	["3", "Charlie", "22"],
	["4", "David", "35"]
]

var filtered_data = []

func _ready():
	setup_tree()
	setup_header_buttons()
	search_box.text_changed.connect(_on_search_text_changed)

func setup_tree():
	tree.clear()
	
	# Spaltennamen setzen
	tree.set_column_titles_visible(true)
	for i in range(len(data[0])):
		tree.set_column_title(i, data[0][i])

	# Daten einfügen
	update_table(data.slice(1))

func setup_header_buttons():
	for child in header_container.get_children():
		child.queue_free()  # ✅ Entfernt alte Buttons, bevor neue hinzugefügt werden.
	
	for i in range(len(data[0])):
		var button = Button.new()
		button.text = data[0][i]
		button.pressed.connect(_on_column_clicked.bind(i))
		header_container.add_child(button)

func update_table(data_array):
	var root = tree.create_item()
	for i in range(len(data_array)):
		var item = tree.create_item(root)
		for j in range(len(data_array[i])):
			item.set_text(j, data_array[i][j])
		# Wechselnde Farben für Zeilen
		if i % 2 == 0:
			item.set_custom_bg_color(0, Color(0.9, 0.9, 0.9))  # Fix: Richtige Funktion für Godot 4 verwenden

func _on_search_text_changed(new_text):
	filtered_data = []
	for row in data.slice(1):
		if new_text.to_lower() in row[1].to_lower():  
			filtered_data.append(row)
	update_table(filtered_data)

func _on_column_clicked(column):
	var sorted_data = filtered_data if filtered_data else data.slice(1)
	sorted_data.sort_custom(func(a, b): return a[column] < b[column])
	update_table(sorted_data)
