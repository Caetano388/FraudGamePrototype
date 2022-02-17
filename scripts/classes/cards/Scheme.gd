extends GraphEdit
class_name Scheme

class Connection:
	var first_card : int
	var second_card : int
	var type : SchemeCard.CardConnectionTypes

var cards : Array[SchemeCard]
var connections : Dictionary[Connection]

var money_capacity_req : int
var respect_req : int
var hype : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_connection(new_connection : Connection) -> bool:
	
func remove_connection(connection_to_remove : Connection) -> bool:

func calculate_impact() -> LocalState:
	for connection in connections:
		
