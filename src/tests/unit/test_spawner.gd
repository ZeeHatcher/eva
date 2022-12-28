extends GutTest


const Spawner := preload("res://etc/spawner/spawner.gd")
const SpawnerScene := preload("res://etc/spawner/spawner.tscn")


func test_spawn_adds_npc_to_tree() -> void:
	var spawner := _instance_spawner()
	var prev_count = get_child_count()
	spawner.spawn(Vector2.ZERO)
	assert_eq(get_child_count(), prev_count + 1)


func test_start_begins_spawning() -> void:
	var spawner := _instance_spawner()
	spawner.spawn_interval = 0.1
	var prev_count = get_child_count()
	spawner.start()
	yield(yield_for(0.21), YIELD)
	assert_gt(get_child_count(), prev_count)


func _instance_spawner() -> Spawner:
	var spawner := SpawnerScene.instance()
	add_child(spawner)
	return spawner as Spawner
