extends Node2D


const FoeScene := preload("res://entities/npcs/foe/foe.tscn")
const FriendScene := preload("res://entities/npcs/friend/friend.tscn")

var points := 0

onready var _spawner := $Spawner
onready var _stopwatch := $Stopwatch
onready var _core := $Core
onready	var _game_over := $"%GameOver"
onready var _camera := $Camera


func _ready() -> void:
	randomize()
	_spawner.stop()
	_stopwatch.stop()
	_core.disable()
	_game_over.hide()


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
	npc.connect("died", self, "_on_NPC_died")
	npc.connect("sacrificed", self, "_on_NPC_sacrificed")


func _update_points(pts: int) -> void:
	points += pts


func _on_NPC_died(pts: int) -> void:
	_camera.shake(5)
	_update_points(pts)


func _on_NPC_sacrificed(pts: int) -> void:
	_update_points(pts)
	

func _on_GameOver_retry():
	var game_scene = load("res://scenes/debug/debug.tscn")
	get_tree().change_scene_to(game_scene)


func _on_Core_destroyed():
	_camera.shake(20)
	_game_over.update_score(points)
	_game_over.show()


func _on_Gun_shot(charge_level: float):
	_camera.shake(charge_level * 5 + 1)


func _on_Core_hurt():
	_camera.shake(10)
