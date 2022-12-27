extends VBoxContainer


signal retry

onready var _score_label = $Score


func update_score(score) -> void:
	_score_label.text = score.to_string()


func _on_Button_pressed():
	emit_signal('retry')
