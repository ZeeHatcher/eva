extends Line2D


var trail_length := 100


func add_trail(pos) -> void:
	add_point(pos)


func _process(delta) -> void:
	while get_point_count() > trail_length:
		remove_point(0)
