extends Area2D
class_name Enemy

signal damaged(damge: int)

const GRACE_MULTIPLIER = 0.9
var health: int = 3
var SFXDictionary: Dictionary

@export var routine: ActionRoutine
@export var statsData: EnemyStats

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var bulletZone: Area2D = $BulletZone
@onready var hitboxShape: CollisionShape2D = $Hitbox/HitboxCollision
@onready var hurtboxShape: CollisionShape2D = $Hurtbox/HurtboxCollision
@onready var levelBullets: Area2D = get_tree().get_nodes_in_group("BulletZones")[0]

var tween: Tween

func _ready():
	connect("damaged", _on_damaged)
	setUpStats()
	sprite.play("default")
	if (routine == null):
		return
	setSpawnPosition()
	await executeRoutine(0)
	if (routine.repeatInfinitely):
		while true:
			await get_tree().create_timer(routine.repetitionCooldown, false).timeout
			await executeRoutine(routine.repeatFrom)

func setUpStats():
	if (statsData == null):
		return
	health = statsData.health
	SFXDictionary = statsData.sfx.data
	
	if (statsData.intangible):
		hitboxShape.disabled = true
		var hurtboxArea = hurtboxShape.get_parent() as Area2D
		hurtboxArea.set_collision_layer_value(2, false)
		hurtboxArea.set_collision_mask_value(2, false)
		sprite.visible = false
	##Code dedicated to automatically modify hitbox size based on sprite
	##Will have to be chang eto accomodate bird shapes
	'''
	sprite.texture = statsData.sprite
	
	hitboxShape.shape.extents = Vector2(sprite.texture.get_width()/2, sprite.texture.get_height()/2) * GRACE_MULTIPLIER
	hurtboxShape.shape.extents = Vector2(sprite.texture.get_width()/2, sprite.texture.get_height()/2) / GRACE_MULTIPLIER
	'''
	
func setSpawnPosition():
	if (routine.spawnDefinedPosition != Positions.definedPositions.EMPTY):
		self.global_position = Positions.getCoordinates(routine.spawnDefinedPosition)
	else:
		self.global_position = routine.spawnPosition

func executeRoutine(startingIndex: int) -> void:
	for i in routine.actions.size()-startingIndex:
		var action: Action = routine.actions[i+startingIndex].duplicate(true)
		if (action.waitBeforeNext):
			await executeAction(action)
		else:
			executeAction(action)
			await get_tree().create_timer(action.overlapTimer, false).timeout

func executeAction(action: Action) -> void:
	var function: Callable
	
	match action.actionType:
		ActionList.actions.Directional_Attack:
			function = func(action):
				await newDirectionalAttack(action)
		ActionList.actions.Directional_Movement:
			function = func(action):
				await directionalMovement(action)
		ActionList.actions.Positional_Movement:
			function = func(action):
				await positionalMovement(action)
	
	for i in action.repetitions:
		await function.call(action)
		await get_tree().create_timer(action.cooldownTime, false).timeout

func positionalMovement(movementSpecs: PositionalMovement) -> void:
	#When using export variable of enum type, by default first element of enum is set
	var finalPosition: Vector2 = movementSpecs.finalPosition
	if (movementSpecs.definedPosition != Positions.definedPositions.EMPTY):
		finalPosition = Positions.getCoordinates(movementSpecs.definedPosition)
	
	if (tween):
		tween.kill()
	tween = self.create_tween()
	tween.tween_property(self, "global_position", finalPosition, movementSpecs.movingTime)
	await tween.finished

func directionalMovement(movementSpecs: DirectionalMovement) -> void:
	if (tween):
		tween.kill()
	tween = self.create_tween()
	var finalPosition = position + (movementSpecs.direction.normalized() * movementSpecs.speed * movementSpecs.movingTime)
	tween.tween_property(self, "global_position", finalPosition, movementSpecs.movingTime)
	await tween.finished

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
		await get_tree().create_timer(patternSpecs.frequency, false).timeout
		for j in patternSpecs.lines:
			spawnBullet(patternSpecs, isParryable(patternSpecs, i))
		if (patternSpecs.spinningPattern):
			patternSpecs.setMainDirection(patternSpecs.mainDirection.rotated(patternSpecs.getSpinRate()))

func spawnBullet(bulletSpecs: DirectionalAttack, parryable: bool) -> void:
	var shape: Shape2D = bulletSpecs.shape
	var speed: float = bulletSpecs.speed
	var direction: Vector2 = bulletSpecs.getDirection().normalized()
	var bullet: Bullet = preload("res://scenes/bullet.tscn").instantiate()
	
	match bulletSpecs.bulletType:
		Attack.bulletTypes.math:
			bullet.set_script(load("res://scripts/nodes_scripts/math_bullet.gd"))
			bullet.mathBulletSetUp(bulletSpecs.function, bulletSpecs.step)
	
	bullet.add_to_group("bullets")
	if (parryable):
		bullet.add_to_group("parryable")
		bullet.find_child("Sprite2D").modulate =  Color("ff33d4")
	bulletZone.add_child(bullet)
	bullet.newBullet(shape, direction, speed)
	bullet.reparent(levelBullets, true)

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

func _on_hurtbox_area_entered(area):
	var parent = area.get_parent()
	if (parent is Bullet && parent.currentState == Bullet.States.parried):
		damaged.emit(1)
		
func _on_damaged(damage: int):
	health -= damage
	if (health<=0):
		SFXManager.sfx_play.emit(SFXDictionary["death"])
		queue_free()
	else:
		SFXManager.sfx_play.emit(SFXDictionary["hit"])
		sprite.modulate = Color("ff1e00")
		await get_tree().create_timer(1, false).timeout
		sprite.modulate = Color(1,1,1,1)
	
