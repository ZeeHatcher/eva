extends Area2D
class_name Projectile


export(int) var speed := 300
export(int) var damage := 1

var direction := Vector2.ONE
var velocity := Vector2.ZERO


func _ready() -> void:
	pass # Replace with function body.


func setup(_damage:int, _direction: Vector2, _speed: int) -> void:
	damage = _damage
	speed = _speed
	direction = _direction 


func _physics_process(delta: float) -> void:
	move(delta)


func move(delta: float) -> void:
	velocity = speed * direction * delta
	position += velocity


func hit(target: KinematicBody2D) -> void:
	target.hurt(damage)


func _on_Projectile_body_entered(body) -> void:
	hit(body)
