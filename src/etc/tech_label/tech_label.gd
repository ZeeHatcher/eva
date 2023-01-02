tool
extends Node2D
class_name TechLabel


var target: NPC setget set_target

onready var label := $Label


func _draw() -> void:
	draw_circle(Vector2.ZERO, 5, Color.white)
	

func _ready() -> void:
	var line := $Line2D
	var points: PoolVector2Array = line.points
	var last := points[points.size() - 1]
	
	points[points.size() - 1] = Vector2(label.rect_position.x + label.rect_size.x, last.y)
	line.points = points


func _physics_process(_delta: float) -> void:
	if not target or not is_instance_valid(target):
		return
	
	position = target.position


func set_target(val: NPC) -> void:
	target = val
	target.connect("died", self, "_on_target_gone")
	target.connect("sacrificed", self, "_on_target_gone")


func _on_target_gone() -> void:
	queue_free()
