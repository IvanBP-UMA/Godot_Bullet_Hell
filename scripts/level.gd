extends Node2D

@onready var spawner = $BulletSpawner
# Called when the node enters the scene tree for the first time.
func _ready():
	var patternSpecs = {
		"rows": 50,
		"speed": 1.5,
		"size": Vector2(15,15),
		"direction": Vector2(0,1),
		"freq": 0.1
	}
	spawner.attackPattern(spawner.patterns["TRIATTACK"], patternSpecs)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
