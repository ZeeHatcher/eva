extends Node2D


signal destroyed
signal hit

export var max_health := 3
export var rotation_speed := 3

onready var health := max_health

onready var _arm := $Arm
onready var _gun := $"%Gun"


func _physics_process(delta: float) -> void:
	_arm.rotation = wrapf(_arm.rotation + rotation_speed * delta, -PI, PI)


func hit() -> void:
	health = max(health - 1, 0)
	emit_signal("destroyed" if health == 0 else "hit")


func heal() -> void:
	health = min(health + 1, max_health)
