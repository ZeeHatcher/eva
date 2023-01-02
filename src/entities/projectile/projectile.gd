extends Area2D
class_name Projectile


const ParticleScene := preload("res://particles/pellet_spray.tscn")
const TrailScene := preload("res://etc/trail/trail.tscn")

export(int) var speed := 300
export(int) var damage := 1
export(int) var trail_length := 50

var direction := Vector2.ONE
var velocity := Vector2.ZERO
var is_crit := false
var shoot_count: int

onready var context: Node = get_parent()
onready var trail: Line2D = TrailScene.instance()

func setup(
		_damage: int, _direction: Vector2, _speed: int,
		_position: Vector2, size_scale: float, 
		_is_crit: bool = false, _shoot_count: int = 0
) -> void:
	damage = _damage
	speed = _speed
	direction = _direction
	position = _position
	is_crit = _is_crit
	shoot_count = _shoot_count
	
	var hitbox := $Hitbox
	var sprite := $Sprite
	
	hitbox.shape.radius = hitbox.shape.radius * size_scale
	sprite.scale = sprite.scale * size_scale


func _ready():
	trail.trail_length = trail_length
	context.add_child(trail)


func _physics_process(delta: float) -> void:
	move(delta)


func move(delta: float) -> void:
	velocity = speed * direction * delta
	position += velocity
	trail.add_trail(position)


func hit(target: NPC) -> void:
	target.hurt(damage, shoot_count)
	
	if not is_crit:
		_emit_particles()
		queue_free()


func _on_Projectile_area_entered(npc: NPC):
	if not npc or npc.is_queued_for_deletion():
		return
	
	if is_queued_for_deletion():
		return
	
	hit(npc)


func despawn() -> void:
	trail.has_source = false
	if is_instance_valid(self) and not is_queued_for_deletion():
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	despawn()


func _emit_particles() -> void:
	var particles := ParticleScene.instance() as Particles2D
	particles.position = position
	particles.rotation = direction.angle()
	context.add_child(particles)
	particles.emitting = true
