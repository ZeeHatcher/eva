extends CanvasLayer

var materials = [
	preload("res://particles/circle_burst.tres"),
	preload("res://particles/circle_burst_2.tres"),
	preload("res://particles/heal_aura.tres"),
	preload("res://particles/lightning.tres"),
	preload("res://particles/lightning_aura.tres"),
	preload("res://particles/pellet_spray.tres"),
	preload("res://particles/triangle_burst.tres"),
]

func _ready():
	for material in materials:
		var particles_instance = Particles2D.new()
		particles_instance.set_process_material(material)
		particles_instance.set_one_shot(true)
		particles_instance.set_emitting(true)
		self.add_child(particles_instance)
