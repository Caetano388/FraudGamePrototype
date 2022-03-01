extends Control

var connection_type: int
var button := $Button
var direction: bool


func set_connection_type(type: int):
	connection_type = type


func set_button_state() -> void:
	pass


func _connecting(type: int, card: int, direction: bool) -> void:
	if type != connection_type or direction != self.direction:
		button.disabled = true
	else:
		# button.modulate


func _stop_connecting(card: int) -> void:
	if button.disabled:
		button.disabled = false