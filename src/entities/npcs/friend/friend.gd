extends NPC
class_name Friend


func _init() -> void:
	points_on_death = -1
	points_on_sacrifice = 1


func _sacrifice_to(core: Core) -> void:
	core.heal()

