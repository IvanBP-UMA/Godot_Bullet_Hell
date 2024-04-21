extends Node
class_name BulletSpawner

@onready var timer: Timer = $Timer

var patterns: Dictionary = {
	PatternList.patterns.spreadPattern: Callable(self, "spreadAttack")
}

func newAttack(patternSpecs: AttackPattern) -> void:
	var function = patterns[patternSpecs.patternName]
	var originalDirection = patternSpecs.mainDirection
	timer.timeout.connect(function.bind(patternSpecs))
	for i in patternSpecs.rows:
		timer.start(patternSpecs.frequency)
		await timer.timeout
		if (patternSpecs.isSpinning):
			patternSpecs.setMainDirection(patternSpecs.mainDirection.rotated(patternSpecs.getSpinRate()))
	patternSpecs.setMainDirection(originalDirection)

func lineAttack(bulletSpecs: AttackPattern) -> void:
	var shape: Shape2D = bulletSpecs.shape
	var speed: float = bulletSpecs.speed
	var direction: Vector2 = bulletSpecs.getDirection().normalized()
	
	var bullet: Bullet = preload("res://scenes/bullet.tscn").instantiate()
	bullet.add_to_group("bullets")
	add_child(bullet)
	bullet.newBullet(shape, direction, speed)

func spreadAttack(bulletSpecs: SpreadPattern) -> void:
	for i in bulletSpecs.lines:
		lineAttack(bulletSpecs)
