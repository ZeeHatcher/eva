extends VBoxContainer


signal retry

onready var _score_label = $Score


func update_score(score) -> void:
	_score_label.text = String(score)


func _on_Button_pressed():
	visible = false
	emit_signal('retry')


func _on_Core_destroyed():
	visible = true
