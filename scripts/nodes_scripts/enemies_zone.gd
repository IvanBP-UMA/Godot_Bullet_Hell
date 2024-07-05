extends Area2D

signal enemies_deleted

func _on_child_exiting_tree(node):
	if (get_child_count() == 1):
		enemies_deleted.emit()
