extends Area2D

var speedMultiplier: float = 3

func _on_area_entered(area):
	if (area is Bullet && area.is_in_group("parryable")):
		area.direction = getDirectionToEnemy(area)
		area.speed *= speedMultiplier
		area.currentState = Bullet.States.parried

func getDirectionToEnemy(bullet: Bullet):
	var enemyPos: Vector2 = bullet.get_parent().global_position
	return (enemyPos-self.global_position).normalized()
