extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
const SPEED: float = 150

func _physics_process(delta):
	if Input.is_action_pressed("moveLeft"):
		direction.x = -1
	if Input.is_action_pressed("moveRight"):
		direction.x = 1
	if Input.is_action_pressed("moveDown"):
		direction.y = 1
	if Input.is_action_pressed("moveUp"):
		direction.y = -1
	
	
	velocity = direction.normalized() * SPEED
	
	move_and_slide()
	direction = Vector2.ZERO
