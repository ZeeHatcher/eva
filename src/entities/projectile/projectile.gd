extends Area2D
class_name Projectile


export(int) var speed := 300
export(int) var damage := 1

var direction := Vector2.ONE
var velocity := Vector2.ZERO
var is_crit := false


func setup(
		_damage: int, _direction: Vector2, _speed: int,
		_position: Vector2, size_scale: float, _is_crit: bool = false
) -> void:
	damage = _damage
	speed = _speed
	direction = _direction
	position = _position
	is_crit = _is_crit
	
	var hitbox := $Hitbox
	var sprite := $Sprite
	
	hitbox.shape.radius = hitbox.shape.radius * size_scale
	sprite.scale = sprite.scale * size_scale


func _physics_process(delta: float) -> void:
	move(delta)


func move(delta: float) -> void:
	velocity = speed * direction * delta
	position += velocity


func hit(target: NPC) -> void:
	print("hit")
	target.hurt(damage)
	
	if not is_crit:
		queue_free()


func _on_Projectile_area_entered(npc: NPC):
	if not npc or npc.is_queued_for_deletion():
		return
	
	if is_queued_for_deletion():
		return
	
	hit(npc)


func despawn() -> void:
	if is_instance_valid(self) and not is_queued_for_deletion():
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	despawn()
