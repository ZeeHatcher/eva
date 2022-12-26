extends Area2D
class_name NPC


export var move_speed := 100 setget set_move_speed

var target: Node2D


func _physics_process(delta) -> void:
	if target:
		var direction := position.direction_to(target.position)
		position += direction * move_speed * delta
		look_at(target.position)


func set_move_speed(val: int) -> void:
	move_speed = max(val, 0)
