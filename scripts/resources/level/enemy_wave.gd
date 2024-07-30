extends LevelEvent
class_name EnemyWave

#List of enemies that will be spawned in this wave
@export var enemies: Array[EnemyDefinition]
#Duration of the wave. It will automatically end after this many seconds have passed
@export var waveTime: float = 10
#If true, wave will go on indefinitely until all enemies are defeated
@export var infiniteWave: bool = false
