extends Node2D

var colors = PoolColorArray([Color.white])
var size = 25
var rng = RandomNumberGenerator.new()
var _shape : PoolVector2Array

func _create_shape():
	if not _shape.empty():
		return
		
	rng.randomize()
	# Between 5 and 9 edges
	var num_of_edges = rng.randi_range(5, 9)
	var points = []
	
	for i in range(num_of_edges):
		points.append(Vector2(rng.randi_range(-size, size), rng.randi_range(-size, size)))
	
	points.sort_custom(self, "_sort_clockwise")
	_shape = PoolVector2Array(points)


func _sort_clockwise(a, b) -> bool:
	return a.angle() < b.angle()

func _draw():
	_create_shape()
	draw_polygon(_shape, colors)

func _ready():
	_create_shape()
	var collider_shape = get_parent().get_node("Collider/CollisionPolygon")
	collider_shape.polygon = _shape

