extends Node2D


export(Color) var epic_color := Color.yellow
export(Color) var danger_color := Color.red
export(int) var max_value := 3

var value setget set_value


func _ready() -> void:
	$AnimationPlayer.play("rise")


func set_value(val: int) -> void:
	var prefix := ""
	
	if val == 1:
		prefix = "+"
	elif val > 1:
		prefix = "x"
	
	var color := Color.white.linear_interpolate(epic_color, float(val) / max_value) if val > 0 else danger_color
	$Label.add_color_override("font_color", color)
	$Label.text = prefix + str(val)


func _on_AnimationPlayer_animation_finished(_anim_name: String):
	queue_free()
