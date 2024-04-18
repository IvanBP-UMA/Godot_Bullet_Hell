extends Node

@onready var timer: Timer = $Timer
var newAttack: bool = false
var patterns: Dictionary = {
	"TRIATTACK": Callable(self, "triAttack")
}

func attackPattern(function: Callable, patternSpecs: Dictionary):
	timer.timeout.connect(function.bind(patternSpecs))
	for i in patternSpecs["rows"]:
		timer.start(patternSpecs["freq"])
		await timer.timeout

func triAttack(bulletSpecs: Dictionary):
	var bulletSize: Vector2 = bulletSpecs["size"]
	var speed: float = bulletSpecs["speed"]
	var direction: Vector2 = bulletSpecs["direction"]
	
	var bullet: Bullet = preload("res://scenes/bullet.tscn").instantiate()
	add_child(bullet)
	bullet.newBullet(bulletSize, direction, speed)
	
	var bullet2: Bullet = preload("res://scenes/bullet.tscn").instantiate()
	add_child(bullet2)
	bullet2.newBullet(bulletSize, (direction.rotated(-PI/6)).normalized(), speed)
	
	var bullet3: Bullet = preload("res://scenes/bullet.tscn").instantiate()
	add_child(bullet3)
	bullet3.newBullet(bulletSize, (direction.rotated(PI/6)).normalized(), speed)
