extends CanvasItem


export(float, 1) var max_value := 1.0 setget set_max_value
export(float) var value setget set_value
export(Color) var base_color := Color.white
export(Color) var end_color := Color.black


func _ready() -> void:
	modulate = base_color


func set_max_value(val: float) -> void:
	max_value = max(val, 1.0)


func set_value(val: float) -> void:
	var weight := range_lerp(val, 0, max_value, 0, 1)
	modulate = end_color.linear_interpolate(base_color, weight)
