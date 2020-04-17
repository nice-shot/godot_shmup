extends Area2D

export var speed := 50
var _destroyed := false

signal exited_screen


func _physics_process(delta: float) -> void:
    position.y -= speed * delta


func _on_Bullet_area_entered(area: Area2D) -> void:
    var asteroid = area.get_parent() as Asteroid
    if (asteroid):
        asteroid.explode()
    _destroyed = true
    queue_free()


func _on_screen_exited() -> void:
    if not _destroyed:
        emit_signal("exited_screen")
    queue_free()
