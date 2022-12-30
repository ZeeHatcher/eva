extends Camera2D


export(float, 0, 1) var decay_weight := 0.5

var strength := 0.0


func _physics_process(_delta: float) -> void:
	if not is_equal_approx(strength, 0):
		var direction := Vector2.RIGHT.rotated(rand_range(-PI, PI))
		offset = direction * strength
	
	strength = lerp(strength, 0, decay_weight)


func shake(strength_: float) -> void:
	strength += strength_
