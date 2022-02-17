extends Resource
class_name CardResource

@export var title : String
@export_multiline var desc : String
@export var cost : int

@export var generate_multiple : bool
@export var multiple_names_source : String
@export var multiple_descs_source : String

@export var full_image : Texture
@export var hotbar_image : Texture

@export var inputs : Array[SchemeCard.CardConnectionTypes]
@export var outputs : Array[SchemeCard.CardConnectionTypes]

@export var money_cap : int
@export var money_req : int
@export var respect_req : int
@export var liability : int

@export var effects : Array[String]
@export var effects_desc : Array[String]
@export_flags("Criminal", "Hidden", "Inactive") var special_modifiers
