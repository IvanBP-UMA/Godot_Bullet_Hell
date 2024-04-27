extends Bullet
class_name MathBullet

enum mathFunctions {sine, cosine, tangent, squareRoot, square, cubic, logaritmic}
var originalDirection: Vector2
var function: mathFunctions
var independentVar: float = 0
var step: float = 0.1
var setUp: bool = false

func _process(delta):
	if (!setUp):
		originalDirection = direction
		print(originalDirection)
		setUp = true
	super(delta)
	updateDirection()
	
func mathBulletSetUp(function: mathFunctions, step: float):
	self.function = function
	self.step = step

func updateDirection():
	var nextPosition: Vector2
	var currentPosition: Vector2
	currentPosition.x = independentVar
	independentVar += step
	nextPosition.x = independentVar
	var currentDirectionAngle = direction.angle()
	
	match function:
		mathFunctions.sine:
			currentPosition.y = sin(independentVar-step)
			nextPosition.y = sin(independentVar)
		mathFunctions.cosine:
			nextPosition.y = cos(independentVar)
		mathFunctions.square:
			nextPosition.y = pow(independentVar, 2)
			
	direction = (nextPosition-currentPosition).rotated(originalDirection.angle()).normalized()
	
