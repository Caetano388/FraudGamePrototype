extends Resource
class_name CardResource

@export var title : String
@export_multiline var desc : String
@export var cost : int

@export var inputs : Array[SchemeCard.CardConnectionTypes]
@export var outputs : Array[SchemeCard.CardConnectionTypes]

@export var money_cap : int
@export var respect_req : int
@export var liability : int

@export var effects : Array[String]
