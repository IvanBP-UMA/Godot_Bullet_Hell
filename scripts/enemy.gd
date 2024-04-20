extends Area2D
class_name Enemy

@export var attackPattern: AttackPattern
var spawner: BulletSpawner

func _ready():
	spawner = preload("res://scenes/bullet_spawner.tscn").instantiate()
	add_child(spawner)
	spawner.newAttack(attackPattern)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
