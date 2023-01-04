extends AudioStreamPlayer

var states = {"Start": 0, "Main": 1, "End": 2}
var loops = {0: [0, 16], 1: [16, 80], 2: [80, 90]}

var current_state = 0


func _ready() -> void:
	play(0)


func _process(delta) -> void:
	if is_last_loop() and get_playback_position() >= loops[current_state][1]:
		stop()
		return
	
	if get_playback_position() >= loops[current_state][1]:
		play(loops[current_state][0])


func set_loop(_state) -> void:
	current_state = states[_state]
	
	if is_last_loop():
		play(loops[current_state][0])


func is_last_loop() -> bool:
	return current_state == (loops.size() - 1)
