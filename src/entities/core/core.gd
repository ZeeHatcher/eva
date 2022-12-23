extends Node2D


signal destroyed
signal hit

export var max_health := 3

onready var health := max_health


func hit() -> void:
	health = max(health - 1, 0)
	emit_signal("destroyed" if health == 0 else "hit")


func heal() -> void:
	health = min(health + 1, max_health)
