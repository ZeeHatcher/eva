extends Area2D
class_name Core


signal destroyed
signal hurt

export var max_health := 3
export var rotation_speed_degrees := 180

var _enabled := true

onready var health := max_health
onready var context: Node = get_parent()

onready var _arm := $Arm
onready var _gun := $"%Gun"


func _ready() -> void:
	_gun.setup(context)


func _physics_process(delta: float) -> void:
	if not _enabled or not Input.is_action_pressed("action"):
		var target_angle: float = _arm.rotation + deg2rad(rotation_speed_degrees) * delta
		_arm.rotation = wrapf(target_angle, -PI, PI)


func setup(ctx: Node) -> void:
	context = ctx
	_gun.setup(ctx)


func hurt() -> void:
	health = max(health - 1, 0)
	
	if health == 0:
		emit_signal("destroyed")
		queue_free()
	else:
		emit_signal("hurt")


func heal() -> void:
	health = min(health + 1, max_health)


func enable() -> void:
	_enabled = true
	_gun.enable()


func disable() -> void:
	_enabled = false
	_gun.disable()
