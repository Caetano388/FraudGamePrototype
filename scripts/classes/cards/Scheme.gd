extends GraphEdit
class_name Scheme

class Connection:
	var first_card: int
	var second_card: int
	var type: SchemeCard.CardConnectionTypes

var cards: Array[SchemeCard]
var connections: Dictionary

var completed_cards: Dictionary

var money_capacity_req: int
var respect_req: int
var hype: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func add_connection(new_connection : Connection) -> bool:
	var cn := connections[new_connection.first_card]
	if cn.outputs.has(new_connection.second_card):
		return false
	else:
		cn.outputs[new_connection.second_card] = new_connection.type
		connections[new_connection.second_card].inputs[new_connection.first_card] = type
	return true


func remove_connection(connection_to_remove : Connection) -> bool:
	if connections.has(connection_to_remove.first_card):
		var cn := connections[connection_to_remove.first_card]
		if cn.outputs.has(connection_to_remove.second_card):
			cn.outputs.erase(connection_to_remove.second_card)
			cn = connections[connection_to_remove]
			if cn.inputs.has(connection_to_remove.first_card):
				cn.inputs.erase(connection_to_remove.first_card)
			else 
				return false
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
