extends Control

var description : String

func set_effect_description(desc : String) -> void:
	description = desc
	$Label.text = description
