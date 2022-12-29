extends VBoxContainer


signal start_game


func hide() -> void:
	visible = false
	set_process_input(false)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		hide()
		emit_signal("start_game")
