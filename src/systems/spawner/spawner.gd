extends Path2D


const FoeScene := preload("res://entities/npcs/foe/foe.tscn")
const FriendScene := preload("res://entities/npcs/friend/friend.tscn")

export var spawn_interval := 1.0 setget set_spawn_interval, get_spawn_interval

onready var context: Node = get_parent()

onready var _spawn_point := $SpawnPoint
onready var _timer := $IntervalTimer


func _ready() -> void:
	_timer.wait_time = spawn_interval


func spawn() -> void:
	_spawn_point.offset = randi()
	var npc := FoeScene.instance()
	npc.global_position = _spawn_point.global_position
	context.add_child(npc)


func start() -> void:
	_timer.start()


func stop() -> void:
	_timer.stop()


func set_spawn_interval(val: float) -> void:
	if _timer:
		_timer.wait_time = val


func get_spawn_interval() -> float:
	if not _timer:
		return 0.0
		
	return _timer.wait_time
