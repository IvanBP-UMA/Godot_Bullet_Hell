extends Attack
class_name DirectionalAttack

@export_group("Pattern Specifications")
## Number of lines of bullets
@export var lines: int = 1
## Number of bullets in each line
@export var rows: int = 1
## Separation between bullets in a row (measured in seconds)
@export var frequency: float = 0.1
## Direction of the main line of bullets.<bl> Every line's direction will be based off of this one
@export var mainDirection: Vector2 = Vector2(0,1)
## If checked, changes the main direction so that it points the player at the start of the pattern
@export var aimPlayer: bool
## If checked, al lines will occupy the same half of the screen as the main direction
@export var frontFacing: bool

@export_subgroup("Spinning Pattern")
## If checked, the main direction will rotate slightly between rows
@export var spinningPattern: bool
## Maximum rotation of the main direction
@export_range(0, 2*PI, 0.001,"or_greater","suffix:rad") var maxRotation: float = 2*PI
## If checked, after reaching the Maximum rotation, the main direction will rotate back to its original state
@export var reverseSpin: bool

var directionCounter: int = 0
var directionsArray: Array[Vector2]
var spinCounter: int = 0

func createDirectionsArray() -> void:
	var angle = 2*PI/lines
	if (frontFacing):
		angle = PI/(2*lines)
	for i in lines:
		if (i%2 != 0):
			directionsArray.append(mainDirection.rotated(((i+1)/2)*angle))
		else:
			directionsArray.append(mainDirection.rotated(-(i/2)*angle))

func getDirection() -> Vector2:
	if (directionsArray.size() == 0):
		createDirectionsArray()
	directionCounter += 1
	return directionsArray[directionCounter%directionsArray.size()]

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
	directionsArray.clear()
	createDirectionsArray()
