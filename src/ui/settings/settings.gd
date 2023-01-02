extends Control


func _on_SFXSlider_value_changed(value):
	var volume = range_lerp(value, 0, 100, -80, 0)
	AudioServer.set_bus_volume_db(1, volume)


func _on_MusicSlider_value_changed(value):
	var volume = range_lerp(value, 0, 100, -80, 0)
	AudioServer.set_bus_volume_db(2, volume)
