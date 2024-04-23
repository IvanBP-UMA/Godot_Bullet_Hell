extends Area2D
class_name Enemy

@export var routine: ActionRoutine
@export var health: int = 1

func _ready():
	executeRoutine()

func executeRoutine():
	for action in routine.actions:
		for i in action.repetitions:
			await executeAction(action)
	
	if (routine.repeatLast):
		while true:
			await executeAction(routine.actions[routine.actions.size()-1])

func executeAction(action: Action):
	match action.actionType:
		ActionList.actions.Spread_Attack:
			await newDirectionalAttack(action)
	
	await get_tree().create_timer(action.cooldownTime).timeout

func getVectorToPlayer() -> Vector2:
	var playerPos: Vector2 = get_tree().get_nodes_in_group("player")[0].global_position
	return (playerPos-self.global_position).normalized()

func newDirectionalAttack(patternSpecs: DirectionalAttack) -> void:
	if (patternSpecs.followPlayer):
		patternSpecs.setMainDirection(getVectorToPlayer())
	var originalDirection: Vector2 = patternSpecs.mainDirection
	
	for i in patternSpecs.rows:
		await get_tree().create_timer(patternSpecs.frequency).timeout
		spreadAttack(patternSpecs)
		if (patternSpecs.isSpinning):
			patternSpecs.setMainDirection(patternSpecs.mainDirection.rotated(patternSpecs.getSpinRate()))
	
	patternSpecs.setMainDirection(originalDirection)

func spreadAttack(bulletSpecs: DirectionalAttack) -> void:
	for i in bulletSpecs.lines:
		lineAttack(bulletSpecs)

func lineAttack(bulletSpecs: Attack) -> void:
	var shape: Shape2D = bulletSpecs.shape
	var speed: float = bulletSpecs.speed
	var direction: Vector2 = bulletSpecs.getDirection().normalized()
	
	var bullet: Bullet = preload("res://scenes/bullet.tscn").instantiate()
	bullet.add_to_group("bullets")
	add_child(bullet)
	bullet.newBullet(shape, direction, speed)