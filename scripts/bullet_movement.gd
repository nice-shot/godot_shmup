extends Area2D

export var speed = 50
var destroyed = false

signal exited_screen

func _physics_process(delta):
    position.y -= speed * delta


func _on_Bullet_area_entered(area: Area2D):
    var asteroid = area.get_parent() as Asteroid
    if (asteroid):
        asteroid.explode()
    destroyed = true
    queue_free()


func _on_screen_exited():
    if not destroyed:
        emit_signal("exited_screen")
    queue_free()
