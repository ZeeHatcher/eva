extends CenterContainer


func _ready() -> void:
	visible = false
	$First.modulate = Color.transparent
	$Second.modulate = Color.transparent


func show() -> void:
	visible = true
	$AnimationPlayer.play("show")


func next() -> void:
	$Second.visible = true
	$AnimationPlayer.play("next")


func remove() -> void:
	$AnimationPlayer.play("remove")


func _on_AnimationPlayer_animation_finished(anim_name: String):
	match anim_name:
		"show":
			$First.visible = true
			$Second.visible = false
		"next":
			$First.visible = false
		"remove":
			queue_free()
