extends Node2D
class_name Level

@export var events: Array[LevelEvent]
@onready var enemiesZone: Area2D = $Enemies

func _ready():
	for event in events:
		await executeEvent(event)

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
