extends GutTest


const Core := preload("res://entities/core/core.gd")
const CoreScene := preload("res://entities/core/core.tscn")


func test_hit_decreases_health() -> void:
	var core: Core = _create_core()
	var prev_health := core.health
	core.hit()
	assert_lt(core.health, prev_health)


func test_hit_does_not_decrease_health_below_zero() -> void:
	var core: Core = _create_core()
	core.health = 0
	core.hit()
	assert_eq(core.health, 0)


func test_hit_emits_hit() -> void:
	var core: Core = _create_core()
	watch_signals(core)
	core.hit()
	assert_signal_emitted(core, "hit")


func test_hit_emits_destroyed_when_health_reaches_zero() -> void:
	var core: Core = _create_core()
	watch_signals(core)
	core.health = 1
	core.hit()
	assert_signal_emitted(core, "destroyed")


func test_heal_increases_health() -> void:
	var core: Core = _create_core()
	core.max_health = 1
	core.health = 0
	core.heal()
	assert_gt(core.health, 0)


func test_heal_does_not_exceed_max_health() -> void:
	var core: Core = _create_core()
	core.max_health = 1
	core.health = 1
	core.heal()
	assert_eq(core.health, 1)


func test_arm_rotates_around_core_by_rotation_speed() -> void:
	var core: Core = _create_core()
	core.rotation_speed = 1
	var prev_rotation: float = core._arm.rotation
	gut.simulate(core, 1, 1)
	assert_eq(core._arm.rotation, prev_rotation + 1)
	

func _create_core() -> Core:
	var core: Core = CoreScene.instance()
	add_child_autofree(core)
	return core
