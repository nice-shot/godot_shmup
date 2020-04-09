extends Timer

var SCREEN_WIDTH = ProjectSettings.get_setting("display/window/size/width")
const SCREEN_MARGIN = 20
const Y = -20
var rnd = RandomNumberGenerator.new()
var asteroid_scene = preload("res://scenes/asteroid.tscn")

func _ready():
    self.connect("timeout", self, "_on_AsteroidSpawner_timeout")

func spawn_asteroid():
    var node = asteroid_scene.instance()
    get_parent().add_child(node)
    var x = rnd.randi_range(SCREEN_MARGIN, SCREEN_WIDTH - SCREEN_MARGIN)
    node.position = Vector2(x, Y)

func _on_AsteroidSpawner_timeout():
    spawn_asteroid()
    self.wait_time = rnd.randf_range(0.2, 1.5)
