extends NPC
class_name Foe


const TriangleBurstScene := preload("res://particles/triangle_burst.tscn")


func _init() -> void:
	points_on_death = 1
	particles_scene = TriangleBurstScene


func get_class() -> String:
	return "Foe"


func _sacrifice_to(core: Core) -> void:
	core.hurt()
