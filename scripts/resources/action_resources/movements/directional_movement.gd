extends Action
class_name DirectionalMovement

@export var direction: Vector2
@export var speed: float
@export var movingTime: float

func setUp(dir: Vector2, spd: float, time: float):
	direction = dir
	speed = spd
	movingTime = time
