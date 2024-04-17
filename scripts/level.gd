extends Node2D

@onready var spawner = $BulletSpawner
# Called when the node enters the scene tree for the first time.
func _ready():
	spawner.attackPattern(5, spawner.patterns["TRIATTACK"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
