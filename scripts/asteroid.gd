class_name Asteroid
extends Node2D

export var size = 50
export var speed = 150
var SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/height")
var edge_disappear_point = SCREEN_HEIGHT + size
onready var manager = get_tree().root.get_node("Main/Game") as GameManager

var rng = RandomNumberGenerator.new()

func _sort_clockwise(a, b) -> bool:
    return a.angle() < b.angle()

func _create_shape() -> PoolVector2Array: 
    rng.randomize()
    # Between 5 and 9 edges
    var num_of_edges = rng.randi_range(5, 9)
    var points = []
    var half_size = size / 2
    
    for _i in range(num_of_edges):
        points.append(Vector2(
            rng.randi_range(-half_size, half_size),
            rng.randi_range(-half_size, half_size)
        ))
    
    points.sort_custom(self, "_sort_clockwise")
    return PoolVector2Array(points)
    
func _ready():
    var shape = _create_shape()
    $Graphic.polygon = shape
    $Collider/CollisionPolygon.polygon = shape

func _physics_process(delta):
    position.y += speed * delta
    if position.y >= edge_disappear_point:
        # Asteroid passed screen edge
        if manager: manager.update_score(-50)
        queue_free()

func explode():
    $ExplodeSFX.play()
    $Graphic.queue_free()
    $Collider.queue_free()
    $Particles2D.emitting = true
    speed = 0
    var error = $Timer.connect("timeout", self, "queue_free")
    if (error):
        print("Couldn't connect free to timeout...")
    $Timer.wait_time = $Particles2D.lifetime;
    $Timer.start()
    if manager: manager.update_score(10)
