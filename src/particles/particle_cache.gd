extends CanvasLayer

var a = preload("res://particles/circle_burst.tscn")
var b = preload("res://particles/circle_burst_2.tscn")
var c = preload("res://particles/heal_aura.tscn")
var d = preload("res://particles/lightning.tscn")
var e = preload("res://particles/lightning_aura.tscn")
var f = preload("res://particles/pellet_spray.tscn")
var g = preload("res://particles/triangle_burst.tscn")


var materials = [
	a,b,c,d,e,f,g
]

func _ready():
	for material in materials:
		var particles_instance = Particles2D.new()
		particles_instance.set_process_material(material)
		particles_instance.set_one_shot(true)
		particles_instance.set_emitting(true)
		self.add_child(particles_instance)
