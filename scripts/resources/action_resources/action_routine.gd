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
## Initial object position when spawned. Doesnt return to position on repetition
@export var spawnPosition: Vector2
## If option is selected, previous spawnPosition variable will be ignored
@export var spawnDefinedPosition: Positions.definedPositions

func _init():
	clamp(repeatFrom, 0, actions.size())
