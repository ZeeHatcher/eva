extends Node2D


const FoeScene := preload("res://entities/npcs/foe/foe.tscn")
const FriendScene := preload("res://entities/npcs/friend/friend.tscn")

onready var _spawner := $Spawner


func _ready() -> void:
	randomize()
	_spawner.start()


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
