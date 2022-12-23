extends GutTest

var projectile: Projectile
var test_speed
var test_dir
var damage

func before_each() -> void:
	test_speed = rand_range(0, 1000)
	test_dir = Vector2(randf(), randf())
	damage = 1
	
	projectile = Projectile.new()
	projectile.setup(damage, test_dir, test_speed)


func test_move():
	projectile.move(1)
	assert_ne(projectile.position, test_speed * test_dir)


func test_hit():
	pending()


func test_despawn():
	projectile.despawn()
	assert_true(projectile.is_queued_for_deletion())
