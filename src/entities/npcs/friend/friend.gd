extends NPC
class_name Friend


const CircleBurstScene := preload("res://particles/circle_burst.tscn")


func _init() -> void:
	points_on_death = -1
	points_on_sacrifice = 1
	particles_scene = CircleBurstScene


func _sacrifice_to(core: Core) -> void:
	core.heal()
