extends Area2D
class_name Projectile


export(int) var speed := 300

var direction := Vector2.ONE
var velocity := Vector2.ZERO


func _ready() -> void:
	pass # Replace with function body.


func setup(_speed: int, _direction: Vector2) -> void:
	speed = _speed
	direction = _direction 


func _physics_process(delta: float) -> void:
	move(delta)


func move(delta: float) -> void:
	velocity = speed * direction * delta
	position += velocity
