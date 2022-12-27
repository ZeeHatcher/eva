extends NPC
class_name Foe


func _init() -> void:
	points_on_death = 1


func _sacrifice_to(core: Core) -> void:
	core.hurt()
