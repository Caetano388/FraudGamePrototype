extends GraphEdit
class_name Scheme

var cards : Array[SchemeCard]

var money_capacity_req : int
var respect_req : int
var hype : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func calculate_impact() -> Dictionary:
	var connection_list := get_connection_list()
	print(connection_list)
	return {"test": 'test'}
