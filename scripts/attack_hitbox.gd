extends Area2D


func _on_area_entered(bullet):
	bullet.direction *= -1
	bullet.speed *= 3
	
	var bulletSprite: Sprite2D = bullet.find_child("Sprite2D")
	bulletSprite.modulate = Color("ff33d4")
