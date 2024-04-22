extends Area2D
class_name Enemy

@export var routine: ActionRoutine
@export var health: int = 1
@export var infiniteAttack: bool
var spawner: BulletSpawner

func _ready():
	spawner = preload("res://scenes/bullet_spawner.tscn").instantiate()
	add_child(spawner)
	for action in routine.actions:
		await executeAction(action)

func executeAction(action: Action):
	if action is SpreadPattern:
		spawner.newAttack(action)
	
	await get_tree().create_timer(action.cooldownTime).timeout

func getVectorToPlayer() -> Vector2:
	var playerPos: Vector2 = get_tree().get_nodes_in_group("player")[0].global_position
	return (playerPos-self.global_position).normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
