extends Node2D


const ProjectileScene := preload("res://entities/projectile/projectile.tscn")

export var charge_speed := 10.0

var charge_level: float

var _x: float

onready var context: Node = get_parent()

onready var _barrel := $Barrel


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("action"):
		_x += delta * charge_speed
		charge_level = _charge(_x)
	
	$ProgressBar.value = charge_level


func _unhandled_input(_event: InputEvent):
	if Input.is_action_just_pressed("action"):
		_x = 0
		charge_level = 0
	
	if Input.is_action_just_released("action"):
		var projectile := ProjectileScene.instance()
		projectile.setup(
				charge_level * 100 + 10,
				Vector2.LEFT.rotated(global_rotation),
				charge_level * 900 + 100,
				_barrel.global_position)
		context.add_child(projectile)


func setup(ctx: Node) -> void:
	context = ctx


func _charge(val: float) -> float:
	return cos(val) * -0.5 + 0.5
