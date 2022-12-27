extends CenterContainer


signal start_game


func hide() -> void:
	visible = false


func _on_Button_pressed() -> void:
	hide()
	emit_signal('start_game')
