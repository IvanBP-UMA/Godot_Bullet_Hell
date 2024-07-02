extends Resource
class_name ActionRoutine

## Actions that the enemy will make
@export var actions: Array[Action]
## If checked, the enemy will repeat its actions after finishing the routine
@export var repeatInfinitely: bool
## Index from wich the routine will repeat itself
@export var repeatFrom: int
## Cooldown before repeating the routine
@export var repetitionCooldown: float = 1
## If checked, the action order will be randomized 
@export var randomRoutineOrder: bool

func _init():
	clamp(repeatFrom, 0, actions.size())
