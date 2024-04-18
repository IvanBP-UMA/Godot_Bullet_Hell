extends Area2D
class_name Bullet

var hitbox: CollisionShape2D
var sprite: Sprite2D
var direction: Vector2
var speed: float
var size: Vector2
var graceMultiplier: float = 1.8

func newBullet(size: Vector2, direction: Vector2, speed: float):
	hitbox.shape.size = size
	self.direction = direction
	sprite.scale = Vector2(size.x/sprite.texture.get_width() * graceMultiplier, size.y/sprite.texture.get_height() * graceMultiplier)
	self.speed = speed
	
func _ready():
	hitbox = $CollisionShape2D
	sprite = $Sprite2D

func _process(delta):
	position += direction * speed

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
