extends Node2D

func _ready():
	print_debug(get_viewport_rect().size)
	var enemy: Enemy = preload("res://scenes/enemy.tscn").instantiate()
	enemy.routine = preload("res://predefined_resources/routines/four_corners.tres")
	self.add_child(enemy)
