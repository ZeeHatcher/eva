extends Area2D
class_name NPC


signal died
signal hurt
signal sacrificed

export var move_speed := 100 setget set_move_speed
export var health := 100 setget set_health

var target: Node2D


func _ready() -> void:
	var players := get_tree().get_nodes_in_group("players")
	if not players.empty():
		target = players[0]
	

func _physics_process(delta) -> void:
	if target:
		var direction := position.direction_to(target.position)
		position += direction * move_speed * delta
		look_at(target.position)


func hurt(damage: int) -> void:
	self.health -= damage
	
	if health == 0:
		emit_signal("died")
		queue_free()
	else:
		emit_signal("hurt")


func sacrifice_to(core: Core) -> void:
	if not core:
		return
	
	_sacrifice_to(core)
	emit_signal("sacrificed")
	queue_free()


func set_move_speed(val: int) -> void:
	move_speed = max(val, 0)


func set_health(val: int) -> void:
	health = max(val, 0)


func _sacrifice_to(_core: Core) -> void:
	pass
