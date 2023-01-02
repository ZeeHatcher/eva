extends Line2D


var trail_length := 20
var has_source := true


func add_trail(pos) -> void:
	add_point(pos)


func _process(_delta) -> void:
	# delete trail if used up
	if not has_source and get_point_count() <= 0:
		queue_free()
		return
	
	# remove a point every frame
	if not has_source:
		remove_point(0)
		return
	
	# remove all excess points
	while get_point_count() > trail_length:
		remove_point(0)
