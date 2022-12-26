extends NPC
class_name Foe


func _sacrifice_to(core: Core) -> void:
	core.hurt()
