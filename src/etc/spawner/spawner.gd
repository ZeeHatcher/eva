extends Path2D


signal spawned(npc)

const FoeScene := preload("res://entities/npcs/foe/foe.tscn")
const FriendScene := preload("res://entities/npcs/friend/friend.tscn")

export var spawn_interval := 1.0 setget set_spawn_interval, get_spawn_interval
export var max_pack_size := 3 setget set_max_pack_size
export var max_offset_distance := 100
export var friend_spawn_chance := 0.1 setget set_friend_spawn_chance

onready var context: Node = get_parent()

onready var _rng := RandomNumberGenerator.new()
onready var _spawn_point := $SpawnPoint
onready var _timer := $IntervalTimer


func _ready() -> void:
	_timer.wait_time = spawn_interval
	_rng.randomize()


func spawn_pack() -> void:
	_spawn_point.unit_offset = _rng.randf()
	var pack_size := _rng.randi_range(1, max_pack_size)
	
	for _i in range(pack_size):
		spawn(_offset_position(_spawn_point.global_position))


func spawn(pos: Vector2) -> void:
	var npc := _randomize_npc()
	npc.global_position = pos
	npc.context = context
	context.add_child(npc)
	emit_signal("spawned", npc)


func start() -> void:
	_timer.start()


func stop() -> void:
	_timer.stop()


func set_spawn_interval(val: float) -> void:
	spawn_interval = val
	if _timer:
		_timer.wait_time = val


func get_spawn_interval() -> float:
	return spawn_interval


func set_max_pack_size(val: int) -> void:
	max_pack_size = max(val, 1)


func set_friend_spawn_chance(val: float) -> void:
	friend_spawn_chance = clamp(val, 0.0, 1.0)


func _randomize_npc() -> NPC:
	var roll := _rng.randf()
	var scene := FriendScene if roll <= friend_spawn_chance else FoeScene
	return scene.instance() as NPC


func _offset_position(pos: Vector2) -> Vector2:
	var angle := _rng.randf_range(-PI, PI)
	var direction := Vector2.RIGHT.rotated(angle)
	var vector := direction * randf() * max_offset_distance
	return pos + vector
