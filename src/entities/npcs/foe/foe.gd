extends NPC
class_name Foe


const ParticlesScene := preload("res://particles/triangle_explosion.tscn")


func _init() -> void:
	points_on_death = 1


func _sacrifice_to(core: Core) -> void:
	core.hurt()
