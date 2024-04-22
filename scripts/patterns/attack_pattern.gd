extends Action
class_name AttackPattern

@export_group("Pattern Specifications")
@export var rows: int = 1
@export var frequency: float = 1
@export var shape: Shape2D
@export var speed: float = 2.5
@export var mainDirection: Vector2 = Vector2(0,1)
@export var followPlayer: bool


@export_subgroup("Spinning Pattern")
@export var isSpinning: bool
@export_range(0, 2*PI, 0.001,"or_greater","suffix:rad") var maxRotation: float = 2*PI
@export var reverseSpin: bool

var spinCounter: int = 0

func getSpinRate() -> float:
	var spinRate: float = maxRotation/rows
	if (reverseSpin):
		spinRate *= 2
		if (spinCounter%rows >= (rows/2)):
			spinRate *= (-1)
		spinCounter += 1
	return spinRate

func setMainDirection(newDir: Vector2) -> void:
	mainDirection = newDir

func getDirection() -> Vector2:
	return mainDirection
