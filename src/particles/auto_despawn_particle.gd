extends Particles2D


func _ready() -> void:
	$Timer.start()


func _on_Timer_timeout():
	queue_free()
