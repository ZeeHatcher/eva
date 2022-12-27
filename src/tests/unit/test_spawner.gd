extends GutTest


const Spawner := preload("res://systems/spawner/spawner.gd")
const SpawnerScene := preload("res://systems/spawner/spawner.tscn")


func test_spawn_adds_npc_to_tree() -> void:
	var spawner := _instance_spawner()
	var prev_count = get_child_count()
	spawner.spawn()
	assert_eq(get_child_count(), prev_count + 1)


func test_start_begins_spawning() -> void:
	var spawner := _instance_spawner()
	spawner.spawn_interval = 0.1
	var prev_count = get_child_count()
	spawner.start()
	yield(yield_for(0.21), YIELD)
	assert_eq(get_child_count(), prev_count + 2)


func _instance_spawner() -> Spawner:
	var spawner := SpawnerScene.instance()
	add_child(spawner)
	return spawner as Spawner
