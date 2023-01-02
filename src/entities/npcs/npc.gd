extends Area2D
class_name NPC


signal died
signal hurt
signal sacrificed

const DieSoundScene := preload("res://assets/sfx/scenes/npc_die_sound.tscn")
const HurtSoundScene := preload("res://assets/sfx/scenes/npc_hurt_sound.tscn")

export var move_speed := 100 setget set_move_speed
export var health := 100 setget set_health

var target: Node2D
var points_on_death: int
var points_on_sacrifice: int
var particles_scene: PackedScene

onready var context: Node = get_parent()

onready var _sprite := $Sprite
onready var _hit_flash := $HitFlash
onready var _base_health := health


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
		context.add_child(DieSoundScene.instance())
		_emit_particles()
		emit_signal("died")
		queue_free()
	else:
		context.add_child(HurtSoundScene.instance())
		emit_signal("hurt")
		_hit_flash.flash(_sprite)
		_update_sprite()


func sacrifice_to(core: Core) -> void:
	if not core:
		return
	
	_sacrifice_to(core)
	emit_signal("sacrificed")
	queue_free()


func kill() -> void:
	_emit_particles()
	queue_free()


func set_move_speed(val: int) -> void:
	move_speed = max(val, 0)


func set_health(val: int) -> void:
	health = max(val, 0)


func _emit_particles() -> void:
	if not particles_scene:
		return
	
	var particles := particles_scene.instance() as Particles2D
	particles.position = position
	context.add_child(particles)
	particles.emitting = true


func _sacrifice_to(_core: Core) -> void:
	pass


func _update_sprite() -> void:
	var damage_category := int(float(health) / _base_health * _sprite.hframes)
	var frame: int = _sprite.hframes - damage_category - 1
	_sprite.frame = frame
