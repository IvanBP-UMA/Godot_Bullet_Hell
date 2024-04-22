extends Area2D
class_name Enemy

signal finishedAction

@export var routine: ActionRoutine
@export var health: int = 1
@export var infiniteAttack: bool

@onready var timer: Timer = $Timer

func _ready():
	executeRoutine()

func executeRoutine():
	for i in routine.actions.size():
		await executeAction(routine.actions[i])

func executeAction(action: Action):
	match action.actionType:
		ActionList.actions.spreadPattern:
			await newDirectionalAttack(action)
			
	await get_tree().create_timer(action.cooldownTime).timeout

func getVectorToPlayer() -> Vector2:
	var playerPos: Vector2 = get_tree().get_nodes_in_group("player")[0].global_position
	return (playerPos-self.global_position).normalized()

func newDirectionalAttack(patternSpecs: AttackPattern) -> void:
	var originalDirection = patternSpecs.mainDirection
	timer.timeout.connect(Callable(self, "spreadAttack").bind(patternSpecs))
	for i in patternSpecs.rows:
		timer.start(patternSpecs.frequency)
		await timer.timeout
		if (patternSpecs.isSpinning):
			patternSpecs.setMainDirection(patternSpecs.mainDirection.rotated(patternSpecs.getSpinRate()))
	patternSpecs.setMainDirection(originalDirection)

func lineAttack(bulletSpecs: AttackPattern) -> void:
	var shape: Shape2D = bulletSpecs.shape
	var speed: float = bulletSpecs.speed
	var direction: Vector2 = bulletSpecs.getDirection().normalized()
	
	var bullet: Bullet = preload("res://scenes/bullet.tscn").instantiate()
	bullet.add_to_group("bullets")
	add_child(bullet)
	bullet.newBullet(shape, direction, speed)

func spreadAttack(bulletSpecs: SpreadPattern) -> void:
	for i in bulletSpecs.lines:
		lineAttack(bulletSpecs)
