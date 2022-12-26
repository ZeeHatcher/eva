extends Area2D
class_name Core


signal destroyed
signal hurt

export var max_health := 3
export var rotation_speed := 3

onready var health := max_health
onready var context: Node = get_parent()

onready var _arm := $Arm
onready var _gun := $"%Gun"


func _ready() -> void:
	_gun.setup(context)


func _physics_process(delta: float) -> void:
	if not Input.is_action_pressed("action"):
		_arm.rotation = wrapf(_arm.rotation + rotation_speed * delta, -PI, PI)


func setup(ctx: Node) -> void:
	context = ctx
	_gun.setup(ctx)


func hurt() -> void:
	health = max(health - 1, 0)
	emit_signal("destroyed" if health == 0 else "hurt")


func heal() -> void:
	health = min(health + 1, max_health)
