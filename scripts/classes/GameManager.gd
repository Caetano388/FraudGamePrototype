extends Node
class_name GameManger

var scheme_card := preload("res://objects/scheme_card.tscn")
@onready var scheme: Node = $Scheme

var game_state := {
	'players': {},
	'schemer': 0,
	'turn': 0
}
# TODO: Make this a singleton, move scheme, etc to a player scene instead,
# Implement Multiplayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	for card in CardDatabase.get_all_cards():
		if card.generate_multiple:
			for i in range(3):
				_create_card(card)
		else:
			_create_card(card)


func _create_card(card: CardResource) -> void:
	var new_card = scheme_card.instantiate()
	new_card.load_card_resource(card)
	scheme.add_child(new_card)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass