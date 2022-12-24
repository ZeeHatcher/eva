extends Node2D


export var charge_speed := 10.0

var charge_level: float

var _x: float


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("action"):
		_x = 0
		charge_level = 0
	
	if Input.is_action_pressed("action"):
		charge(delta * charge_speed)
	
	if Input.is_action_just_released("action"):
		pass
	
	$ProgressBar.value = charge_level


func charge(val: float) -> void:
	_x += val
	charge_level = cos(_x) * -0.5 + 0.5
