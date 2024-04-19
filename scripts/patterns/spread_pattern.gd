extends MultipleLinePattern
class_name SpreadPattern

@export var frontFacing: bool

func createDirectionsArray():
	var angle = 2*PI/lines
	if (frontFacing):
		angle = PI/(2*lines)
	for i in lines:
		if (i%2 != 0):
			directionsArray.append(mainDirection.rotated(((i+1)/2)*angle))
		else:
			directionsArray.append(mainDirection.rotated(-(i/2)*angle))

