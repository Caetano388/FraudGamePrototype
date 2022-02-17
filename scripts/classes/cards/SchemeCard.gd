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

var index : int

var connection_button := preload("res://objects/connection_button.tscn")
var effect_desc := preload("res://objects/effect_description.tscn")

var liability : int
var desc : String
var money_capacity : int
var money_req : int
var respect_req : int

var incoming_state : LocalState
var new_state : LocalState

var effects : Array[String]
var effects_desc : Array[String]
@onready var effect_container := $Effects

var input_slots : Array[CardConnectionTypes]
var output_slots : Array[CardConnectionTypes]
var connection_slots := { INPUT: input_slots, OUTPUT: output_slots }
@onready var connection_containers : Array[Node] = [$Inputs, $Outputs]

func load_card_resource(data : CardResource) -> void:
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

	prepare_slots(INPUT)
	prepare_slots(OUTPUT)

func prepare_slots(direction : int) -> void:
	var slots : Array[CardConnectionTypes] = connection_slots[direction]
	var container := connection_containers[INPUT]
	for slot in slots:
		container.add_child(connection_button.instantiate())

func _ready() -> void:
	$Description.text = desc

func apply_effects(new_incoming_state : LocalState) -> void:
	incoming_state = new_incoming_state
	for effect in effects:
		var new_expression = Expression.new()
		new_expression.parse(effect)
		new_expression.execute([], self)
