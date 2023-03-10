extends Control


signal retry

onready var _score_label = $"%Score"


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		hide()
		emit_signal("retry")


func show() -> void:
	visible = true
	get_tree().create_timer(0.3).connect("timeout", self, "_on_Timer_timeout")
	$AnimationPlayer.play("float")


func hide() -> void:
	visible = false
	set_process_input(false)
	$AnimationPlayer.stop()


func update_score(score) -> void:
	_score_label.text = String(score)


func _on_Timer_timeout() -> void:
	set_process_input(true)
