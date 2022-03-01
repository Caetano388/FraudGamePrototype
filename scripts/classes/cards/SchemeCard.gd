extends GraphNode
class_name SchemeCard

# TODO: Refactor SchemeCard as a class that can be added as a child to the
# various card nodes.

enum {
	INPUT,
	OUTPUT
}

enum CardConnectionTypes {
	MONEY,
	RESPECT,
	POPULARITY,
}

var index: int

var connection_button := preload("res://objects/connection_button.tscn")
var effect_desc := preload("res://objects/effect_description.tscn")
var connection_string := preload("res://objects/connection_string.tscn")

var liability: int
var desc: String
var money_capacity: int
var money_req: int
var respect_req: int

var is_final: bool

var incoming_state: LocalState
var new_state: LocalState

var effects: Array[String]
var effects_desc: Array[String]
@onready var effect_container := $Effects

var input_slots: Array[CardConnectionTypes]
var output_slots: Array[CardConnectionTypes]
var connection_slots := { INPUT: input_slots, OUTPUT: output_slots }
@onready var connection_containers: Array[Node] = [$Inputs, $Outputs]
var scheme: Scheme
var con_string: ConnectionString

func load_card_resource(data: CardResource) -> void:
	title = data.title
	desc = data.desc
	liability = data.liability
	input_slots = data.inputs
	output_slots = data.outputs
	effects = data.effects

	for effect in effects:
		var fx := effect_desc.instantiate()
		fx.set_effect_description(effect)
		$Effects.add_child(fx)

	_prepare_slots(INPUT)
	_prepare_slots(OUTPUT)

	if data.generate_multiple:
		_set_card_name()


func _set_card_name(source: String) -> void:
	var names = CardDatabase.names[source]
	var c_name: String = ''
	if names is Dictionary:
		for key in names.keys():
			c_name += _random_select_text(names[key])
	
	else:
		c_name = _random_select_text(names)
	title = c_name


func _set_card_desc(source: String) -> void:
	var descs = CardDatabase.descriptions[source]
	var c_desc: String = _random_select_text(descs)
	desc = c_desc


func _random_select_text(text_arr: Array[String]) -> String:
	return text_arr[randi() % text_arr.size()]


func _prepare_slots(direction: int) -> void:
	var slots: Array[CardConnectionTypes] = connection_slots[direction]
	var container := connection_containers[INPUT]
	for slot in slots:
		var new_connection_button := connection_button.instantiate()
		container.add_child(new_connection_button)
		new_connection_button.direction = bool(direction)
		new_connection_button.button.pressed.connect(
			_on_slot_pressed(new_connection_button.type,
			new_connection_button.direction,
			new_connection_button
		))
		scheme.began_connecting.connect(new_connection_button._connecting)
		scheme.completed_connecting.connect(new_connection_button._stop_connecting)


func _on_slot_pressed(type: int, direction: bool, btn: Node) -> void:
	if scheme.is_connecting:
		scheme.completed_connecting.emit(index)
		if con_string:
			remove_child(con_string)
	else:
		scheme.began_connecting.emit(type, index, direction)
		con_string = connection_string.instantiate()
		con_string.add_point(btn.position)
		con_string.add_point(get_viewport().get_mouse_position())
		con_string.follow_mouse = true
		add_child(con_string)


func _ready() -> void:
	$Description.text = desc
	scheme = get_parent()


func apply_effects(new_incoming_state: LocalState) -> LocalState:
	incoming_state = new_incoming_state
	for effect in effects:
		var new_expression = Expression.new()
		new_expression.parse(effect)
		new_expression.execute([], self)
	return new_state
