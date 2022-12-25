extends Node2D


const ProjectileScene := preload("res://entities/projectile/projectile.tscn")

export var charge_speed := 10.0

var charge_level: float

var _x: float

onready var context: Node = get_parent()

onready var _barrel := $Barrel
onready var _left_spread_boundary := $LeftSpreadBoundary
onready var _right_spread_boundary := $RightSpreadBoundary


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("action"):
		_charge(delta * charge_speed)
		_update_boundaries_position()


func _unhandled_input(_event: InputEvent):
	if Input.is_action_just_pressed("action"):
		_reset_charge()
		_show_spread_boundaries(true)
	
	if Input.is_action_just_released("action"):
		_show_spread_boundaries(false)
		_shoot()
	
	_update_boundaries_position()


func setup(ctx: Node) -> void:
	context = ctx


func _charge(val: float) -> void:
	_x += val
	charge_level = cos(_x) * -0.5 + 0.5


func _reset_charge() -> void:
	_x = 0
	charge_level = 0


func _shoot() -> void:
	var projectile_count := int(charge_level * -10) + 10
	var damage := charge_level * 100 + 10
	var speed := charge_level * 900 + 100
	var spread := _calculate_spread()
	
	for n in range(projectile_count):
		var projectile := ProjectileScene.instance()
		var direction := global_rotation
		
		projectile.setup(
				damage,
				_calculate_direction(projectile_count, n, spread),
				speed,
				_barrel.global_position)
		context.add_child(projectile)


func _calculate_direction(count: int, index: int, spread: float) -> Vector2:
	var offset = 0.0
	
	if count > 1:
		offset = range_lerp(index, 0, count - 1, -spread, spread)
	
	return Vector2.LEFT.rotated(global_rotation + offset)


func _calculate_spread() -> float:
	return range_lerp(charge_level, 1.0, 0.0, 0, deg2rad(60))


func _show_spread_boundaries(show: bool) -> void:
	_left_spread_boundary.visible = show
	_right_spread_boundary.visible = show


func _update_boundaries_position() -> void:
	var spread := _calculate_spread()
	
	var _left_points: PoolVector2Array = _left_spread_boundary.points
	_left_points[1] = Vector2.LEFT.rotated(global_rotation - spread) * 128
	_left_spread_boundary.points = _left_points
	
	var _right_points: PoolVector2Array = _right_spread_boundary.points
	_right_points[1] = Vector2.LEFT.rotated(global_rotation + spread) * 128
	_right_spread_boundary.points = _right_points
	
