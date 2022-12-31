extends Reference
class_name ParticlesEmitter


var context: Node
var particles_scene: PackedScene


func _init(ctx: Node = null, particles_scene_: PackedScene = null) -> void:
	context = ctx
	particles_scene = particles_scene_


func emit(pos: Vector2) -> void:
	var particles := particles_scene.instance() as Particles2D
	particles.position = pos
	context.add_child(particles)
	particles.emitting = true
