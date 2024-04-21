extends Area2D
class_name Enemy

@export var attackPattern: AttackPattern
@export var health: int = 1
@export var infiniteAttack: bool
var spawner: BulletSpawner

func _ready():
	spawner = preload("res://scenes/bullet_spawner.tscn").instantiate()
	add_child(spawner)
	if infiniteAttack:
		while true:
			if (attackPattern.followPlayer): 
				attackPattern.setMainDirection(getVectorToPlayer())
			await spawner.newAttack(attackPattern)
	spawner.newAttack(attackPattern)

func getVectorToPlayer() -> Vector2:
	var playerPos: Vector2 = get_tree().get_nodes_in_group("player")[0].global_position
	return (playerPos-self.global_position).normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
