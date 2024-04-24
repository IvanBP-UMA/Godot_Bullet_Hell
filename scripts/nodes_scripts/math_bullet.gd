extends Bullet
class_name MathBullet

enum mathFunctions {sine, cosine, tangent, squareRoot, square, cubic, logaritmic}
var function: mathFunctions
var independentVar: float = 0
var step: float = 0.1

func _process(delta):
	super(delta)
	updateDirection()
	
func mathBulletSetUp(function: mathFunctions, step: float):
	self.function = function
	self.step = step

func updateDirection():
	var nextPosition: Vector2
	independentVar += step
	nextPosition.x = independentVar
	var currentDirectionAngle = direction.angle()
	
	match function:
		mathFunctions.sine:
			nextPosition.y = sin(independentVar)
		mathFunctions.cosine:
			nextPosition.y = cos(independentVar)
		mathFunctions.square:
			nextPosition.y = pow(independentVar, 2)
			
	direction = direction.rotated(currentDirectionAngle - nextPosition.rotated(currentDirectionAngle).angle())
	
