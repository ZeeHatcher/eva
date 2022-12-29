extends VBoxContainer


signal retry

onready var _score_label = $Score


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		hide()
		emit_signal("retry")


func show() -> void:
	visible = true
	set_process_input(true)


func hide() -> void:
	visible = false
	set_process_input(false)


func update_score(score) -> void:
	_score_label.text = String(score)
