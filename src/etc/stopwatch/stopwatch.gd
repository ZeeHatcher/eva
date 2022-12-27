extends Node
class_name Stopwatch


export(float) var time_elapsed setget set_time_elapsed, get_time_elapsed

var _paused := true


func _process(delta: float) -> void:
	if _paused:
		return
	
	time_elapsed += delta


func seconds() -> int:
	return int(time_elapsed)


func minutes() -> int:
	return seconds() / 60


func start() -> void:
	_paused = false


func stop() -> void:
	_paused = true


func set_time_elapsed(val: float) -> void:
	time_elapsed = max(val, 0)


func get_time_elapsed() -> float:
	return time_elapsed
