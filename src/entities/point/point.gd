extends Node2D


var value setget set_value


func _ready() -> void:
	$AnimationPlayer.play("rise")


func set_value(val: int) -> void:
	var prefix := ""
	
	if val == 1:
		prefix = "+"
	elif val > 1:
		prefix = "x"
	
	$Label.text = prefix + str(val)


func _on_AnimationPlayer_animation_finished(_anim_name: String):
	queue_free()
