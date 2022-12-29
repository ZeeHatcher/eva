extends GutTest


const ProjectileScene := preload("res://entities/projectile/projectile.tscn")

var projectile: Projectile
var test_speed
var test_dir
var damage
var is_crit


func before_each() -> void:
	test_speed = rand_range(0, 1000)
	test_dir = Vector2(randf(), randf())
	damage = 1
	is_crit = (randf() > 0.5)
	
	projectile = ProjectileScene.instance()
	add_child(projectile)
	projectile.setup(damage, test_dir, test_speed, Vector2.ZERO, 1.0, is_crit)


func test_move():
	projectile.move(1)
	assert_ne(projectile.position, test_speed * test_dir)


func test_despawn():
	projectile.despawn()
	assert_true(projectile.is_queued_for_deletion())

