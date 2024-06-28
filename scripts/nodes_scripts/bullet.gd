extends Area2D
class_name Bullet

var hitbox: CollisionShape2D
var sprite: Sprite2D
var direction: Vector2
var speed: float
var graceMultiplier: float = 1.8
enum States {default, parried}
var currentState: States
@onready var parentEnemy = self.get_parent()

func newBullet(shape: Shape2D, direction: Vector2, speed: float) -> void:
	hitbox.shape = shape
	self.direction = direction
	if (shape.get_class() == "RectangleShape2D"):
		sprite.scale = Vector2(shape.size.x/sprite.texture.get_width() * graceMultiplier, shape.size.y/sprite.texture.get_height() * graceMultiplier)
	else:
		var scale = shape.radius*2/sprite.texture.get_width() * graceMultiplier
		sprite.scale = Vector2(scale, scale)
	self.speed = speed
	
func _ready():
	hitbox = $CollisionShape2D
	sprite = $Sprite2D
	currentState = States.default

func _process(delta):
	movementHandler()
	
func movementHandler():
	match currentState:
		States.default:
			defaultMovement()
		States.parried:
			parriedMovement()

func defaultMovement():
	position += direction * speed

func parriedMovement():
	position += direction * speed

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
