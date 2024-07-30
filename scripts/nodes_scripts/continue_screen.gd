extends Control

func _ready():
	var tween: Tween = create_tween()
	tween.tween_property($TextureRect, "self_modulate:a", 1, 3)
	tween.tween_property($YesButton, "self_modulate:a", 1, 2)
	tween.tween_property($NoButton, "self_modulate:a", 1, 2)


func _on_yes_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_no_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
