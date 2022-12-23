extends GutTest

var projectile: Projectile
var test_speed = 200
var test_dir = Vector2(randi(), randi())


func before_each() -> void:
	test_speed = rand_range(0, 1000)
	test_dir = Vector2(randf(), randf())
	
	projectile = Projectile.new()
	projectile.setup(test_speed, test_dir)


func test_move():
	projectile.move(1)
	assert_ne(projectile.position, test_speed * test_dir)


func test_hit():
	pass
