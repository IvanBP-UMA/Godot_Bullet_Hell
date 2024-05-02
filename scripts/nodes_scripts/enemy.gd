extends Area2D
class_name Enemy

@export var routine: ActionRoutine
@export var health: int = 1

func _ready():
	await executeRoutine(0)
	if (routine.repeatInfinitely):
		while true:
			await get_tree().create_timer(routine.repetitionCooldown).timeout
			await executeRoutine(routine.repeatFrom)

func executeRoutine(startingIndex: int):
	for i in routine.actions.size()-startingIndex:
		var action: Action = routine.actions[i+startingIndex]
		if (action.waitBeforeNext):
			await executeAction(action)
		else:
			executeAction(action)
			await get_tree().create_timer(action.overlapTimer).timeout

func executeAction(action: Action) -> void:
	var function: Callable
	
	match action.actionType:
		ActionList.actions.Directional_Attack:
			function = func (action):
				await newDirectionalAttack(action)
	
	for i in action.repetitions:
		await function.call(action)
		await get_tree().create_timer(action.cooldownTime).timeout

func newDirectionalAttack(patternSpecs: DirectionalAttack) -> void:
	if (patternSpecs.aimPlayer):
		patternSpecs.setMainDirection(getVectorToPlayer())
	var originalDirection: Vector2 = patternSpecs.mainDirection
	await shootDirectionalAttack(patternSpecs)
	patternSpecs.setMainDirection(originalDirection)

func shootDirectionalAttack(patternSpecs: DirectionalAttack) -> void:
	for i in patternSpecs.rows:
		if (patternSpecs.followPlayer):
			patternSpecs.setMainDirection(getVectorToPlayer())
		await get_tree().create_timer(patternSpecs.frequency).timeout
		for j in patternSpecs.lines:
			spawnBullet(patternSpecs, isParryable(patternSpecs, i))
		if (patternSpecs.spinningPattern):
			patternSpecs.setMainDirection(patternSpecs.mainDirection.rotated(patternSpecs.getSpinRate()))

func spawnBullet(bulletSpecs: DirectionalAttack, parryable: bool) -> void:
	var shape: Shape2D = bulletSpecs.shape
	var speed: float = bulletSpecs.speed
	var direction: Vector2 = bulletSpecs.getDirection().normalized()
	
	var bullet
	if (bulletSpecs.wavyAttack):
		bullet = preload("res://scenes/math_bullet.tscn").instantiate()
		bullet.mathBulletSetUp(bulletSpecs.function, bulletSpecs.step)
	else:
		bullet = preload("res://scenes/bullet.tscn").instantiate()
	
	bullet.add_to_group("bullets")
	if (parryable):
		bullet.add_to_group("parryable")
		bullet.find_child("Sprite2D").modulate =  Color("ff33d4")
	add_child(bullet)
	bullet.newBullet(shape, direction, speed)

func isParryable(patternSpecs: DirectionalAttack, row: int) -> bool:
	var parryable: bool = false
	match patternSpecs.parryMode:
		Attack.parryModes.chance:
			parryable = randi_range(0,1)
		Attack.parryModes.last:
			parryable = (row>=patternSpecs.rows - patternSpecs.parryRows)
		Attack.parryModes.start:
			parryable = (row<patternSpecs.parryRows)
		Attack.parryModes.middle:
			var middleRow: int = patternSpecs.rows/2
			parryable = (row >= middleRow-patternSpecs.parryRows/2 && row <= middleRow + patternSpecs.parryRows/2)
		Attack.parryModes.always:
			parryable = true
		Attack.parryModes.never:
			parryable = false
	
	return parryable

func getVectorToPlayer() -> Vector2:
	var playerPos: Vector2 = get_tree().get_nodes_in_group("player")[0].global_position
	return (playerPos-self.global_position).normalized()
