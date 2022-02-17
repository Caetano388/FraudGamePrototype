extends Node

var cards : Array[Resource]
var names : Dictionary
var descriptions : Dictionary

func _ready() -> void:
	var directory := Directory.new()
	directory.open("res://data/cards")
	directory.list_dir_begin()
	var filename := directory.get_next()
	while (filename):
		if not directory.current_is_dir():
			cards.append(load("res://data/cards/%s" % filename))
		
		filename = directory.get_next()
	load_json_files('names', names, directory)
	load_json_files('descs', descriptions, directory)

func load_json_files(
	dir : String,
	data : Dictionary,
	directory : Directory):

	var file := File.new()
	var json := JSON.new()
	dir = "res://data/" + dir
	directory.change_dir(dir)
	directory.list_dir_begin()
	var filename := directory.get_next()
	while (filename):
		if not directory.current_is_dir():
			dir += "/%s"
			file.open(dir % filename, File.READ)
			var trimmed_name : String = filename.split(".")[0]
			if json.parse(file.get_as_text()) == OK:
				names.trimmed_name = json.get_data()
			file.close()
			filename = directory.get_next()

func get_card(card_name : String) -> Resource:
	for c in cards:
		if c.name == card_name:
			return c
	
	return null

func get_all_cards() -> Array[Resource]:
	return cards
