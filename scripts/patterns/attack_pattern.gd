extends Resource
class_name AttackPattern

@export var rows: int
@export var frequency: float
@export var size: Vector2 = Vector2(5,5)
@export var speed: float = 2.5
@export var mainDirection: Vector2 = Vector2(0,1)

func getDirection():
	return mainDirection
