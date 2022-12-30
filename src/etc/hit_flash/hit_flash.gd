extends Node
class_name HitFlash


export(Color) var original_color
export(Color) var flash_color := Color.white
export(float) var duration := 0.1


func flash(obj: CanvasItem) -> void:
	obj.modulate = flash_color
	get_tree().create_timer(duration).connect("timeout", self, "_on_Timer_timeout", [obj])


func _on_Timer_timeout(obj: CanvasItem) -> void:
	obj.modulate = original_color
