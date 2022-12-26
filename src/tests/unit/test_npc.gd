extends GutTest


func test_move_speed_does_not_go_below_zero() -> void:
	var npc := NPC.new()
	npc.move_speed = -1
	assert_eq(npc.move_speed, 0)


func test_health_does_not_go_below_zero() -> void:
	var npc := NPC.new()
	npc.health = -1
	assert_eq(npc.health, 0)


func test_moves_towards_target() -> void:
	var npc := NPC.new()
	var target: Node2D = double(Node2D).new()
	target.position = Vector2.ZERO
	npc.move_speed = 100
	npc.position = Vector2(100, 100)
	npc.target = target
	var distance = npc.position.distance_to(target.position)
	npc._physics_process(1)
	assert_eq(npc.position.distance_to(target.position), distance - 100)


func test_looks_at_target() -> void:
	var npc := NPC.new()
	var target: Node2D = double(Node2D).new()
	target.position = Vector2.ZERO
	npc.position = Vector2(-100, -100)
	npc.target = target
	npc._physics_process(1)
	assert_eq(npc.rotation_degrees, 45)


func test_hurt_reduces_health_by_damage() -> void:
	var npc := NPC.new()
	npc.health = 100
	npc.hurt(10)
	assert_eq(npc.health, 90)


func test_hurt_emits_hurt() -> void:
	var npc := NPC.new()
	watch_signals(npc)
	npc.health = 100
	npc.hurt(1)
	assert_signal_emitted(npc, "hurt")


func test_hurt_emits_died_when_health_reaches_zero() -> void:
	var npc := NPC.new()
	watch_signals(npc)
	npc.health = 1
	npc.hurt(1)
	assert_signal_emitted(npc, "died")


func test_hurt_despawns_when_health_reaches_zero() -> void:
	var npc := NPC.new()
	npc.health = 1
	npc.hurt(1)
	assert_true(npc.is_queued_for_deletion())


func test_sacrifice_to_emits_sacrificed() -> void:
	var npc := NPC.new()
	watch_signals(npc)
	var core: Core = double(Core).new()
	npc.sacrifice_to(core)
	assert_signal_emitted(npc, "sacrificed")


func test_despawns_when_sacrificed() -> void:
	var npc := NPC.new()
	var core: Core = double(Core).new()
	npc.sacrifice_to(core)
	assert_true(npc.is_queued_for_deletion())


func test_foe_hurts_core_when_sacrificed() -> void:
	var foe := Foe.new()
	var core: Core = double(Core).new()
	foe.sacrifice_to(core)
	assert_called(core, "hurt")
