extends Bullet
class_name MathBullet

enum mathFunctions {line, sine, cosine, tangent, squareRoot, square, cubic, logaritmic}

var currentDirection: Vector2
var function: Callable
var independentVar: float = 0
var step: float = 0.1

func _process(delta):
	super(delta)

func mathBulletSetUp(function: mathFunctions, step: float):
	self.step = step
	setFunction(function)

func setFunction(function: mathFunctions) -> void:
	match function:
		mathFunctions.line:
			self.function = func (value):
				return value
		mathFunctions.sine:
			self.function = func (value):
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


func updateDirection() -> void:
	if (currentDirection == null):
		currentDirection = direction
	
	var currentPosition: Vector2 = Vector2(independentVar, function.call(independentVar))
	independentVar += step
	var nextPosition: Vector2 = Vector2(independentVar, function.call(independentVar))

	currentDirection = (nextPosition-currentPosition).rotated(direction.angle()).normalized()

func defaultMovement():
	position += currentDirection * speed
	updateDirection()

func parriedMovement():
	if (currentDirection != direction):
		currentDirection = direction
	position += currentDirection * speed
