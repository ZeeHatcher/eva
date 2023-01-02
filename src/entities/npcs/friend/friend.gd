extends NPC
class_name Friend


const CircleBurstScene := preload("res://particles/circle_burst.tscn")


func _init() -> void:
	points_on_death = -3
	points_on_sacrifice = 3
	particles_scene = CircleBurstScene


func get_class() -> String:
	return "Friend"


func _sacrifice_to(core: Core) -> void:
	core.heal()
