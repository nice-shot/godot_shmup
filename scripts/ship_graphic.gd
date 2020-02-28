extends Node2D

var size = 40
var colors = PoolColorArray([Color.white])
var shape = PoolVector2Array([
	# Top
	Vector2(0, -(size / 2)),
	# Left
	Vector2(-(size / 2), size / 2),
	# Right
	Vector2(size / 2, size / 2),
])

func _draw():
	draw_polygon(shape, colors)

func _ready():
	var collider = get_parent().get_node("Collider/CollisionPolygon")
	collider.polygon = shape
