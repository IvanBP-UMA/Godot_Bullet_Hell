extends Area2D
class_name Bullet

enum States {default, parried}
const GRACE_MULTIPLIER: float = 1.2

@onready var hitboxShape: CollisionShape2D = $Hitbox/HitboxCollision
@onready var hurtboxShape: CollisionShape2D = $Hurtbox/HurtboxCollision
@onready var sprite: Sprite2D = $Sprite2D
@onready var currentState: States = States.default
@onready var parentEnemy = self.get_parent()

var direction: Vector2
var speed: float

func newBullet(shape: Shape2D, direction: Vector2, speed: float) -> void:
	hitboxShape.shape = shape
	self.direction = direction
	
	if (shape.get_class() == "RectangleShape2D"):
		sprite.scale = Vector2(shape.size.x/sprite.texture.get_width() * GRACE_MULTIPLIER, shape.size.y/sprite.texture.get_height() * GRACE_MULTIPLIER)
	else:
		var scale = shape.radius*2/sprite.texture.get_width() * GRACE_MULTIPLIER
		sprite.scale = Vector2(scale, scale)
		
	self.speed = speed
	hurtboxShape.shape = CircleShape2D.new()
	hurtboxShape.shape.radius = sprite.texture.get_width()/GRACE_MULTIPLIER

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
