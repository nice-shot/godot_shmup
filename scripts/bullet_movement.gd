extends Area2D

export var speed = 50
onready var manager = get_tree().root.get_node("Main/Game") as GameManager
var destroyed = false

func _physics_process(delta):
    position.y -= speed * delta


func _on_Bullet_area_entered(area: Area2D):
    var asteroid = area.get_parent() as Asteroid
    if (asteroid):
        asteroid.explode()
    destroyed = true
    queue_free()


func _on_VisibilityNotifier2D_screen_exited():
    if not destroyed: manager.update_score(-5)
    queue_free()
