extends Node2D
class_name Level
 
@export var acts: Array[LevelAct]
var currentActData: LevelAct
@onready var enemiesZone: Area2D = $Enemies

func _ready():
	setCurrentAct()
	spawnPlayer()
	playAct()

func setCurrentAct():
	if ActTracker.currentAct == null:
		currentActData = acts[0]
		ActTracker.updateCurrentAct(currentActData)
	else:
		currentActData = ActTracker.currentAct

func spawnPlayer():
	var player = preload("res://scenes/player.tscn").instantiate()
	$PlayerZone.add_child(player)
	if currentActData.playerStartDefinedPosition == Positions.definedPositions.EMPTY:
		player.global_position = currentActData.playerStartPosition
	else:
		player.global_position = Positions.getCoordinates(currentActData.playerStartDefinedPosition)

func playAct():
	var eventCounter = 0
	for event in currentActData.events:
		await executeEvent(event)
		eventCounter += 1
		if eventCounter == currentActData.events.size():
			updateActTracker()
			setCurrentAct()
			playAct()

func updateActTracker():
	var actIndex: int = acts.find(currentActData)
	if (actIndex < acts.size() - 1):
		ActTracker.updateCurrentAct(acts[actIndex + 1])
	else:
		ActTracker.resetTracker()
		endLevel()

func executeEvent(event: LevelEvent):
	if (event is EnemyWave):
		await spawnEnemies(event)
		await get_tree().create_timer(event.nextEventWait, false).timeout
		
func spawnEnemies(wave: EnemyWave):
	for enemyDefinition in wave.enemies:
		var enemy: Enemy = preload("res://scenes/enemy.tscn").instantiate()
		enemy.routine = enemyDefinition.routine
		enemy.statsData = enemyDefinition.stats
		enemiesZone.add_child(enemy)
		
	if (wave.infiniteWave):
		await enemiesZone.enemies_deleted
	else:
		await get_tree().create_timer(wave.waveTime, false).timeout

func endLevel():
	
	get_tree().quit()
