extends Bullet
class_name MathBullet

enum mathFunctions {sine, cosine, tangent, squareRoot, square, cubic, logaritmic}

var originalDirection: Vector2
var function: Callable
var independentVar: float = 0
var step: float = 0.1
var setUp: bool = false

func _process(delta):
	if (!setUp):
		originalDirection = direction
		setUp = true
	else:
		super(delta)
		updateDirection()
	
@warning_ignore("shadowed_variable")
func mathBulletSetUp(function: mathFunctions, step: float):
	self.step = step
	match function:
		mathFunctions.sine:
			self.function = func (value) :
				return sin(value)
		mathFunctions.cosine:
			self.function = func (value):
				return cos(value)
		mathFunctions.tangent:
			self.function = func (value):
				return tan(value)
		mathFunctions.square:
			self.function = func (value):
				return pow(value, 2)
		mathFunctions.squareRoot:
			self.function = func (value):
				return sqrt(value)
	

func updateDirection():
	var currentPosition: Vector2 = Vector2(independentVar, function.call(independentVar))
	independentVar += step
	var nextPosition: Vector2 = Vector2(independentVar, function.call(independentVar))

	direction = (nextPosition-currentPosition).rotated(originalDirection.angle()).normalized()
	
