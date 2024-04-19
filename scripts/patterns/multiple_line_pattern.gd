extends AttackPattern
class_name MultipleLinePattern

@export var lines: int
var directionCounter: int = 0
var directionsArray: Array[Vector2]

func createDirectionsArray():
	# Cannot create abstract class in gdscript AFAIK, this is the best I could come up with
	pass

func setMainDirection(newDir: Vector2):
	mainDirection = newDir
	directionsArray.clear()
	createDirectionsArray()

func getDirection():
	if (directionsArray.size() == 0):
		createDirectionsArray()
	directionCounter += 1
	return directionsArray[directionCounter%directionsArray.size()]
