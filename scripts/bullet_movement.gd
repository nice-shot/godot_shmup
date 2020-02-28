extends Area2D

export var speed = 50

func _physics_process(delta):
	position.y -= speed * delta


func _on_Bullet_area_entered(area: Area2D):
	var asteroid = area.get_parent() as AsteroidMovement
	if (asteroid):
		asteroid.explode()
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
