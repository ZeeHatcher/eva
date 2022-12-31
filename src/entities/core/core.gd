extends Area2D
class_name Core


signal destroyed
signal hurt

const HitParticleScene := preload("res://particles/lightning.tscn")
const HealParticleScene := preload("res://particles/heal_aura.tscn")
const DestroyParticleScene := preload("res://particles/circle_burst.tscn")

export var max_health := 3
export var rotation_speed_degrees := 180

var _enabled := true

onready var health := max_health
onready var context: Node = get_parent()

onready var _arm := $Arm
onready var _gun := $"%Gun"
onready var _sprite := $Sprite
onready var _hit_flash := $HitFlash 


func _ready() -> void:
	_gun.setup(context)
	_hit_flash.original_color = _sprite.modulate


func _physics_process(delta: float) -> void:
	if not _enabled or not _gun.can_shoot or not Input.is_action_pressed("action"):
		var target_angle: float = _arm.rotation + deg2rad(rotation_speed_degrees) * delta
		_arm.rotation = wrapf(target_angle, -PI, PI)


func setup(ctx: Node) -> void:
	context = ctx
	_gun.setup(ctx)


func hurt() -> void:
	health = max(health - 1, 0)
	
	if health == 0:
		emit_signal("destroyed")
		_emit_particle(DestroyParticleScene, _sprite.modulate)
		queue_free()
	else:
		emit_signal("hurt")
		_emit_particle(HitParticleScene)
		_hit_flash.flash(_sprite)


func heal() -> void:
	health = min(health + 1, max_health)
	_emit_particle(HealParticleScene)


func enable() -> void:
	_enabled = true
	_gun.enable()


func disable() -> void:
	_enabled = false
	_gun.disable()


func _emit_particle(scene: PackedScene, color_override: Color = Color.black) -> void:
	var particles := scene.instance() as Particles2D
	context.add_child(particles)
	particles.position = position
	if color_override:
		particles.process_material.color = color_override
	particles.emitting = true
