extends Resource
class_name Action

@export var cooldownTime: float = 1
@export var actionType: ActionList.actions
@export var repetitions: int = 1
const MAX_COOLDOWN = 100

func _init():
	clamp(cooldownTime, 0, MAX_COOLDOWN)
