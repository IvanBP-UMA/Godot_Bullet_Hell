extends Node
class_name BulletSpawner

@onready var timer: Timer = $Timer
var patterns: Dictionary = {
	"spreadAttack": Callable(self, "spreadAttack"),
	"spinningAttack": Callable(self, "spinningAttack")
}

func newAttack(function: Callable, patternSpecs: AttackPattern):
	timer.timeout.connect(function.bind(patternSpecs))
	for i in patternSpecs.rows:
		timer.start(patternSpecs.frequency)
		await timer.timeout

func lineAttack(bulletSpecs: AttackPattern):
	var bulletSize: Vector2 = bulletSpecs.size
	var speed: float = bulletSpecs.speed
	var direction: Vector2 = bulletSpecs.getDirection().normalized()
	
	var bullet: Bullet = preload("res://scenes/bullet.tscn").instantiate()
	add_child(bullet)
	bullet.newBullet(bulletSize, direction, speed)

func spreadAttack(bulletSpecs: SpreadPattern):
	for i in bulletSpecs.lines:
		lineAttack(bulletSpecs)

func spinningAttack(bulletSpecs: SpreadPattern):
	for i in bulletSpecs.lines:
		lineAttack(bulletSpecs)
	bulletSpecs.setMainDirection(bulletSpecs.mainDirection.rotated(PI/12))
