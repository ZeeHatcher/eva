extends VBoxContainer


signal start_game
signal load_tutorial

func _ready():
	$AnimationPlayer.play("float")

func hide() -> void:
	visible = false
	set_process_input(false)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		hide()
		emit_signal("start_game")
	
	if event.is_action_pressed("helpme"):
		hide()
		emit_signal("load_tutorial")
