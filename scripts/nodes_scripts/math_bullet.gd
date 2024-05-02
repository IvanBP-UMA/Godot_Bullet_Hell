extends Bullet
class_name MathBullet

enum mathFunctions {line, sine, cosine, tangent, squareRoot, square, cubic, logaritmic}

var mainDirection: Vector2
var function: Callable
var independentVar: float = 0
var step: float = 0.1
var setUp: bool = false

func _process(delta):
	if (!setUp):
		setMainDirection(direction)
		setUp = true
	else:
		super(delta)
		updateDirection()

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

func setMainDirection(newir: Vector2) -> void:
	mainDirection = newir

func updateDirection() -> void:
	var currentPosition: Vector2 = Vector2(independentVar, function.call(independentVar))
	independentVar += step
	var nextPosition: Vector2 = Vector2(independentVar, function.call(independentVar))

	direction = (nextPosition-currentPosition).rotated(mainDirection.angle()).normalized()
	
