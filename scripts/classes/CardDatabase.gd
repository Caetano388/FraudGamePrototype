extends Node

var cards : Array[Resource]

func _ready() -> void:
	var directory := Directory.new()
	directory.open("res://data/cards")
	directory.list_dir_begin()
	var filename := directory.get_next()
	while (filename):
		if not directory.current_is_dir():
			cards.append(load("res://data/cards/%s" % filename))
		
		filename = directory.get_next()

func get_card(card_name : String) -> Resource:
	for c in cards:
		if c.name == card_name:
			return c
	
	return null

func get_all_cards() -> Array[Resource]:
	return cards
