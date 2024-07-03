extends CharacterBody2D
class_name Player

@export var speed: float = 200
@export var lives: int = 3
@export var bombs: int = 3

@onready var hurtbox: Area2D = $Hurtbox
@onready var sprite: Sprite2D = $Sprite
@onready var attackHitbox: Area2D = $AttackHitbox

var direction: Vector2 = Vector2.ZERO
var isAttacking: bool = false
var speedMultiplier: float = 3
var attackPower: int = 2


func _physics_process(delta):
	if Input.is_action_pressed("moveLeft"):
		direction.x = -1
	if Input.is_action_pressed("moveRight"):
		direction.x = 1
	if Input.is_action_pressed("moveDown"):
		direction.y = 1
	if Input.is_action_pressed("moveUp"):
		direction.y = -1
	
	
	velocity = direction.normalized() * speed
	
	move_and_slide()
	direction = Vector2.ZERO

func _input(event):
	if event.is_action_pressed("bomb") && bombs>0:
		bomb()
	if event.is_action_pressed("attack") && !isAttacking:
		attack()

func attack() -> void:
	isAttacking = true
	sprite.modulate = Color("0835ff")
	
	var strikedObjects: Array[Area2D] = attackHitbox.get_overlapping_areas()
	for area in strikedObjects:
		var parent = area.get_parent()
		if (parent is Bullet && parent.is_in_group("parryable")):
			var bullet: Bullet = parent
			bullet.direction = getDirectionToEnemy(bullet)
			bullet.speed *= speedMultiplier
			bullet.currentState = Bullet.States.parried
		elif (parent is Enemy):
			var enemy: Enemy = parent
			enemy.health -= attackPower
	
	await get_tree().create_timer(0.3).timeout
	sprite.modulate = Color(1,1,1,1)
	isAttacking = false

func getDirectionToEnemy(bullet: Bullet):
	var direction: Vector2
	if (is_instance_valid(bullet.parentEnemy)):
		var enemyPos: Vector2 = bullet.parentEnemy.global_position
		direction = (enemyPos-self.global_position).normalized()
	else:
		direction = bullet.direction.normalized() * (-1)
	return direction

func bomb() -> void:
	bombs -= 1
	var bullets = get_tree().get_nodes_in_group("bullets")
	for bullet in bullets:
		bullet.queue_free()

func _on_hurtbox_area_entered(area):
	lives -= 1
	if (lives == 0):
		get_tree().paused = true
		print_debug("GAME OVER")
		
	sprite.modulate = Color("ff1e00")
	hurtbox.set_collision_mask_value(1, false)
	await get_tree().create_timer(1.5, false).timeout
	hurtbox.set_collision_mask_value(1, true)
	sprite.modulate = Color(1,1,1,1)
