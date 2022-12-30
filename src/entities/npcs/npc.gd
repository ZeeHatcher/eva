extends Area2D
class_name NPC


signal died(points)
signal hurt
signal sacrificed(points)

export var move_speed := 100 setget set_move_speed
export var health := 100 setget set_health

var target: Node2D
var points_on_death: int
var points_on_sacrifice: int

onready var _sprite := $Sprite
onready var _hit_flash := $HitFlash


func _ready() -> void:
	var players := get_tree().get_nodes_in_group("players")
	if not players.empty():
		target = players[0]
	
	_hit_flash.original_color = _sprite.modulate
	

func _physics_process(delta) -> void:
	if not is_instance_valid(target):
		target = null
	
	if target:
		var direction := position.direction_to(target.position)
		position += direction * move_speed * delta
		look_at(target.position)


func hurt(damage: int) -> void:
	self.health -= damage
	
	if health == 0:
		emit_signal("died", points_on_death)
		queue_free()
	else:
		emit_signal("hurt")
		_hit_flash.flash(_sprite)


func sacrifice_to(core: Core) -> void:
	if not core:
		return
	
	_sacrifice_to(core)
	emit_signal("sacrificed", points_on_sacrifice)
	queue_free()


func set_move_speed(val: int) -> void:
	move_speed = max(val, 0)


func set_health(val: int) -> void:
	health = max(val, 0)


func _sacrifice_to(_core: Core) -> void:
	pass
