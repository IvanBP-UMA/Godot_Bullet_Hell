extends Action
class_name Attack

enum parryModes {chance, start, middle, last, always, never}

@export var parryMode: parryModes
@export var parryRows: int = 2

@export_group("Bullet Details")
## Shape of the bullets
@export var shape: Shape2D = CircleShape2D.new()
## Speed of the bullets
@export var speed: float = 2.5

@export_subgroup("Changing direction")
## If checked, the direction of the bullets will be variable
@export var wavyAttack: bool
## Mathematical function to determine the variation of its direction
@export var function: MathBullet.mathFunctions
## Precision when calculating the next point of the mathematical function
@export var step: float = 0.1

func _init():
	shape.set_radius(5)
