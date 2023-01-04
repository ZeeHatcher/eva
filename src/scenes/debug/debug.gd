extends Node2D


const FoeScene := preload("res://entities/npcs/foe/foe.tscn")
const FriendScene := preload("res://entities/npcs/friend/friend.tscn")
const PointScene := preload("res://entities/point/point.tscn")

var points := 0
var shot_kills := {}

var _spawned = {
	"Friend": false,
	"Foe": false,
}

onready var _spawner := $Spawner
onready var _stopwatch := $Stopwatch
onready var _core := $Core
onready	var _game_over := $"%GameOver"
onready var _shaker := $Shaker
onready var _bgm := $BGM


func _ready() -> void:
	randomize()
	_spawner.stop()
	_stopwatch.stop()
	_core.disable()
	_game_over.hide()
	_shaker.camera = $Camera


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
	npc.connect("died_by", self, "_on_NPC_died_by", [npc])
	npc.connect("died", _shaker, "_on_NPC_died")
	npc.connect("sacrificed", self, "_on_NPC_sacrificed", [npc])


func _on_Stopwatch_tick() -> void:
	var seconds: int = _stopwatch.seconds()
	_spawner.spawn_interval = max(exp(seconds * -0.005 + 1.1), 1)
	_spawner.max_pack_size = min(floor(seconds * 0.025 + 1), 5)


func _start_game() -> void:
	_spawner.start()
	_stopwatch.start()
	get_tree().create_timer(0.3).connect("timeout", self, "_on_BufferTimer_timeout")
	
	_spawner.spawn_interval = 3
	_spawner.max_pack_size = 1
	
	_bgm.set_loop("Main")


func _on_StartMenu_start_game():
	_start_game()


func _on_StartMenu_load_tutorial():
	#To do for myself gotta go out soon
	#Create a whole separate state (tutorial)
	#keep the thing spinning and use signals to keep track of state
	#add text instructions (maybe do the dudududu thing from FF)
	#Let players freely control the thing with spacebar
	#Spawn one enemy, slow down time (Engine.time_scale) and zoom in on enemy
	#Ask player to shoot enemy
	#Spawn friend
	#Slow down time and zoom, let player absorb friend
	#Keep track of player by assigning tutorial values (in case player just shoots friend) if >=1
	#friend absorbed, send signal to move on
	#After ready, run start game function
	pass


func _on_Spawner_spawned(npc: NPC) -> void:
	npc.connect("died_by", self, "_on_NPC_died_by", [npc])
	npc.connect("died", _shaker, "_on_NPC_died")
	npc.connect("sacrificed", self, "_on_NPC_sacrificed", [npc])
	
	match npc.get_class():
		"Friend":
			if not _spawned["Friend"]:
				$FriendLabel.target = npc
				$FriendLabel.visible = true
				_spawned["Friend"] = true
		"Foe":
			if not _spawned["Foe"]:
				$FoeLabel.target = npc
				$FoeLabel.visible = true
				_spawned["Foe"] = true


func _update_points(pts: int) -> void:
	points += pts


func _on_NPC_died_by(shoot_count: int, npc: NPC) -> void:
	var points = npc.points_on_death
	
	if npc.get_class() == "Foe":
		if !shot_kills.has(shoot_count):
			shot_kills[shoot_count] = 0
		shot_kills[shoot_count] += 1
		points *= shot_kills[shoot_count]
	
	_update_points(points)
	_pop_up_point(npc.position, points)


func _on_NPC_sacrificed(npc: NPC) -> void:
	_update_points(npc.points_on_sacrifice)
	_pop_up_point(_core.position, npc.points_on_sacrifice, false)
	

func _on_GameOver_retry():
	var game_scene = load("res://scenes/debug/debug.tscn")
	get_tree().change_scene_to(game_scene)


func _on_Core_destroyed():
	var npcs := get_tree().get_nodes_in_group("npcs")
	for npc in npcs:
		npc.kill()
	if has_node("%Instructions"):
		$"%Instructions".queue_free()
	
	_game_over.update_score(points)
	_game_over.show()
	
	_bgm.set_loop("End")


func _on_BufferTimer_timeout() -> void:
	_core.enable()
	$"%Instructions".show()


func _pop_up_point(pos: Vector2, value: int, mult := true) -> void:
	if value == 0:
		return
	
	var point := PointScene.instance()
	add_child(point)
	point.position = pos
	point.set_value(value, mult)


func _on_Gun_cocked():
	$"%Instructions".next()
	_core._gun.disconnect("cocked", self, "_on_Gun_cocked")
	_core._gun.connect("shot", self, "_on_Gun_shot")


func _on_Gun_shot(_charge_level: float):
	$"%Instructions".remove()
	_core._gun.disconnect("shot", self, "_on_Gun_shot")
