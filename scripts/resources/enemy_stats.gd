extends Resource
class_name  EnemyStats

#Enemy health points
@export var health: int = 1
#Enemy sprite. Hitbox and hurtbox will be created accordingly to its size
@export var sprite: CompressedTexture2D = load("res://assets/Knuckles.png")
