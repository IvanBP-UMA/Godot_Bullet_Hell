extends Resource
class_name AttackPattern

@export_group("Pattern Specifications")
## Number of bullets shot in the same direction
@export var rows: int = 1
## Separation (measured in seconds) between rows
@export var frequency: float = 1
## Shape of the bullets
@export var shape: Shape2D
## Speed of the bullets
@export var speed: float = 2.5
## Direction of the bullets
@export var mainDirection: Vector2 = Vector2(0,1)
@export var followPlayer: bool
## Name of the pattern
@export var patternName: PatternList.patterns

@export_subgroup("Spinning Pattern")
## Flag to make the pattern spin
@export var isSpinning: bool
## Maximum rotation from initial rotation
@export_range(0, 2*PI, 0.001,"or_greater","suffix:rad") var maxRotation: float = 2*PI
## Flag to make the attack reach its maximum rotation and return to its original direction
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
