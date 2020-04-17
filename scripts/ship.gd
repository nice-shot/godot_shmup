extends Node2D

export var speed: int = 20
var size: int = 40
var min_x: int = size / 2
var max_x: int = ProjectSettings.get_setting("display/window/size/width") - size / 2
var bullet = preload("res://scenes/bullet.tscn")
var shape := PoolVector2Array([
    # Top
    Vector2(0, -(size / 2)),
    # Left
    Vector2(-(size / 2), size / 2),
    # Right
    Vector2(size / 2, size / 2),
])

signal destroyed


func _ready() -> void:
    $Graphic.polygon = shape
    $Collider/CollisionPolygon.polygon = shape


func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_select"): _shoot()


func _physics_process(delta: float) -> void:
    if Input.is_action_pressed("ui_left"): _move(-speed * delta)
    if Input.is_action_pressed("ui_right"): _move(speed * delta)


func _move(amount: int) -> void:
    position.x += amount
    # Clamp position
    if (position.x < min_x): position.x = min_x
    if (position.x > max_x): position.x = max_x


func _shoot() -> void:
    var new_bullet = bullet.instance()
    new_bullet.position = Vector2(position.x, position.y - 25)
    $ShootSFX.play()
    get_parent().add_child(new_bullet)
    new_bullet.connect(
        "exited_screen",
        get_parent(),
        "_on_bullet_exit_screen"
    )


func _on_Collider_area_entered(area: Area2D) -> void:
    var asteroid = area.get_parent() as Asteroid
    if (asteroid):
        asteroid.explode()
        emit_signal("destroyed")
    
