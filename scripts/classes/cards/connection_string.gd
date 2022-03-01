extends Line2D
class_name ConnectionString


var follow_mouse: bool = false


func _process() -> void:
    if follow_mouse:
        set_point_position(1, get_viewport().get_mouse_position())