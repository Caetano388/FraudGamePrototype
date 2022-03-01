extends GraphEdit
class_name Scheme

class Connection:
	var first_card: int
	var second_card: int
	var type: SchemeCard.CardConnectionTypes


signal began_connecting(type: int, card: int, direction: bool)
signal completed_connecting(card: int)


var cards: Array[SchemeCard]
var connections: Dictionary

var completed_cards: Dictionary

var money_capacity_req: int
var respect_req: int
var hype: int

var is_connecting: bool = false
var desired_type: int
var first_card: int
var desired_direction: bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	began_connecting.connect(_on_began_connecting)
	completed_connecting.connect(_on_completed_connecting)


func add_connection(new_connection : Connection) -> bool:
	var cn := connections[new_connection.second_card]
	if cn.inputs.has(new_connection.first_card):
		return false
	else:
		cn.inputs[new_connection.first_card] = new_connection.type
	return true


func remove_connection(connection_to_remove : Connection) -> bool:
	var cn := connections[connection_to_remove.second_card]
	if cn.inputs.has(connection_to_remove.first_card):
		cn.inputs.erase(connection_to_remove.first_card)
		return true
	return false


func calculate_impact() -> void:
	completed_cards = {}
	for out_card in connections:
		_run_state_updates(out_card)


func _run_state_updates(card: int) -> LocalState:
	if (completed_cards.has(card)):
		return completed_cards[card]
	var new_states: Array[LocalState] = []
	var updated_state := LocalState.new()
	for input in cards[card].inputs:
		if completed_cards.has(input):
			new_states.append(completed_cards[input])
		else:
			_run_state_updates(input)
	if !new_states.size() > 0:
		updated_state = new_states.pop_back()
		for state in new_states:
			updated_state.state_merge(state)
	updated_state = cards[card].apply_effects(updated_state)
	completed_cards[card] = updated_state
	return updated_state


func _on_began_connecting(type: int, card: int, direction: bool) -> void:
	is_connecting = true
	desired_type = type
	first_card = card
	desired_direction = direction


func _on_completed_connecting(card: int) -> void:
	var new_connection := Connection.new()
	new_connection.first_card = first_card
	new_connection.second_card = card
	new_connection.type = desired_type
	if desired_direction:
		new_connection.first_card = card
		new_connection.second_card = card
#	if !add_connection(new_connection):
	is_connecting = false