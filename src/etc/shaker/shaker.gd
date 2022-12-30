extends Node
class_name Shaker


export(int) var min_gun_shot_shake := 1
export(int) var gun_shot_shake := 5
export(int) var core_hurt_shake := 10
export(int) var core_destroyed_shake := 20
export(int) var npc_died_shake := 5


var camera: Camera2D


func _on_Core_hurt():
	_shake(core_hurt_shake)


func _on_Core_destroyed():
	_shake(core_destroyed_shake)


func _on_Gun_shot(charge_level: float):
	_shake(charge_level * gun_shot_shake + min_gun_shot_shake)


func _on_NPC_died(_pts: int) -> void:
	_shake(npc_died_shake)


func _shake(strength: int) -> void:
	if not camera:
		return
	
	camera.shake(strength)
