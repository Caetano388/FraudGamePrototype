extends GraphNode
class_name SchemeCard

enum CardConnectionTypes {
	MONEY,
	RESPECT,
	POPULARITY,
}

var connection_button := preload("res://objects/connection_button.tscn")
var effect_desc := preload("res://objects/effect_description.tscn")

var liability : int
var desc : String

var incoming_state : LocalState
var new_state : LocalState

var effects : Array[String]

func load_card_resource(data : CardResource) -> void:
	title = data.title
	desc = data.desc
	liability = data.liability
	input_slots = data.inputs
	output_slots = data.outputs
	effects = data.effects
	
	for effect in data.effects:
		var fx := effect_desc.instantiate()
		fx.set_effect_description(effect)
		$Effects.add_child(fx)

	for in_slot in input_slots:
		var new_input := connection_button.instantiate()
		$Inputs.add_child(new_input)

	for out_slot in output_slots:
		var new_output := connection_button.instantiate()
		$Outputs.add_child(new_output)

func _ready() -> void:
	$Description.text = desc

func apply_effects(new_incoming_state : LocalState) -> void:
	incoming_state = new_incoming_state
	for effect in effects:
		var new_expression = Expression.new()
		new_expression.parse(effect)
		new_expression.execute([], self)

var input_slots : Array[CardConnectionTypes]
var output_slots : Array[CardConnectionTypes]
