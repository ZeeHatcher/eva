extends Node2D


const FoeScene := preload("res://entities/npcs/foe/foe.tscn")
const FriendScene := preload("res://entities/npcs/friend/friend.tscn")

var points := 0

onready var _spawner := $Spawner
onready var _stopwatch := $Stopwatch
onready var _core := $Core


func _ready() -> void:
	randomize()
	_spawner.stop()
	_stopwatch.stop()
	_core.disable()


func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventKey:
		return
	
	if event.scancode == KEY_Q and event.pressed:
		_spawn_npc(FoeScene)
	
	if event.scancode == KEY_W and event.pressed:
		_spawn_npc(FriendScene)
	
	if event.scancode == KEY_A and event.pressed:
		_spawner.start()
	
	if event.scancode == KEY_S and event.pressed:
		_spawner.stop()


func _spawn_npc(scene: PackedScene) -> void:
	var npc := scene.instance()
	npc.target = $Core
	npc.position = get_viewport().get_mouse_position()
	add_child(npc)


func _on_Stopwatch_tick() -> void:
	var seconds: int = _stopwatch.seconds()
	_spawner.spawn_interval = max(exp(seconds * -0.005 + 1.1), 1)
	_spawner.max_pack_size = min(floor(seconds * 0.025 + 1), 5)


func _start_game() -> void:
	_spawner.start()
	_stopwatch.start()
	_core.enable()
	
	_spawner.spawn_interval = 3 # exp(1.1)
	_spawner.max_pack_size = 1


func _on_StartMenu_start_game():
	_start_game()


func _on_Spawner_spawned(npc: NPC) -> void:
	npc.connect("died", self, "_update_points")
	npc.connect("sacrificed", self, "_update_points")


func _update_points(pts: int) -> void:
	points += pts


func _on_GameOver_retry():
	var game_scene = load("res://scenes/debug/debug.tscn")
	get_tree().change_scene_to(game_scene)


func _on_Core_destroyed():
	$"%GameOver".update_score(points)
