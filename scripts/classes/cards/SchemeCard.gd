extends GraphNode
class_name SchemeCard

enum CardConnectionTypes {
	MONEY,
	RESPECT,
	POPULARITY,
}

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
