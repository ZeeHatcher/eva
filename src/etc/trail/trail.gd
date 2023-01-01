extends Line2D


var trail_length := 20
var has_source := true


func add_trail(pos) -> void:
	add_point(pos)


func _process(delta) -> void:
	if not has_source:
		remove_point(0)
		return
	
	while get_point_count() > trail_length:
		remove_point(0)
