extends AudioStreamPlayer


func _process(_delta):
	if not playing:
		queue_free()
