extends GutTest


func test_move_speed_does_not_go_below_zero() -> void:
	var npc := NPC.new()
	npc.move_speed = -1
	assert_eq(npc.move_speed, 0)


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
