extends Node

@onready var timer: Timer = $Timer
var newAttack: bool = false
var patterns: Dictionary = {
	"TRIATTACK": "triAttack"
}


func attackPattern(rows: int, functionName: String):
	var function: Callable = Callable(self, functionName)
	timer.connect("timeout", function)
	for i in rows:
		print(i)
		timer.start(1)
		await timer.timeout

func triAttack():
		var bullet: Bullet = preload("res://scenes/bullet.tscn").instantiate()
		add_child(bullet)
		bullet.newBullet(Vector2(12.5,12.5), Vector2(0, 1), 1)
		
		var bullet2: Bullet = preload("res://scenes/bullet.tscn").instantiate()
		add_child(bullet2)
		bullet2.newBullet(Vector2(12.5,12.5), Vector2(0.25, 1).normalized(), 1)
		
		var bullet3: Bullet = preload("res://scenes/bullet.tscn").instantiate()
		add_child(bullet3)
		bullet3.newBullet(Vector2(12.5,12.5), Vector2(-0.25, 1).normalized(), 1)
