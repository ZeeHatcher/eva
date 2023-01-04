extends AudioStreamPlayer

var states = {"Start": 0, "Main": 1, "End": 2}
var loops = {0: [0, 16], 1: [16, 80], 2: [80, -1]}

var current_state = 0


func _ready() -> void:
	play(0)


func set_loop(_state) -> void:
	current_state = states[_state]
	
	if current_state == 2:
		play(loops[current_state][0])


func _process(delta) -> void:
	if loops[current_state][1] == -1:
		return
	
	if get_playback_position() >= loops[current_state][1]:
		play(loops[current_state][0])
