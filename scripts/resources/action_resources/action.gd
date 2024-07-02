extends Resource
class_name Action

## Type of action. 
@export var actionType: ActionList.actions
## Cooldown after the action is finished (also intervenes between repetitions)
@export var cooldownTime: float = 1.0
## Number of repetitions of the actions
@export var repetitions: int = 1
## If unchecked, the next action in the routine will start without waiting for the current action to finish
@export var waitBeforeNext: bool = true
## Wait time before starting the overlapping action
@export var overlapTimer: float = 0.0

const MAX_COOLDOWN = 100

func _init():
	clamp(cooldownTime, 0, MAX_COOLDOWN)
