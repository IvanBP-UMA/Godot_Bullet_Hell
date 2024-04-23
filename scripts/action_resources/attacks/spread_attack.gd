extends DirectionalAttack
class_name SpreadAttack

@export_group("Spread Pattern")
@export var frontFacing: bool
@export var lines: int = 1

var directionCounter: int = 0
var directionsArray: Array[Vector2]

func setMainDirection(newDir: Vector2) -> void:
	super(newDir)
	directionsArray.clear()
	createDirectionsArray()

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

