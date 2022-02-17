extends Node
class_name GameManger

var scheme_card = preload("res://objects/scheme_card.tscn")
@onready var scheme : Node = $Scheme

var game_state := {
	'players': {},
	'schemer': 0,
	'turn': 0
}
# TODO: Make this a singleton, move scheme, etc to a player scene instead,
# Implement Multiplayer

# Called when the node enters the scene tree for the first time.
func _ready():
	for card in CardDatabase.get_all_cards():
		var new_card = scheme_card.instantiate()
		new_card.load_card_resource(card)
		scheme.add_child(new_card)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
