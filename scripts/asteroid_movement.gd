class_name AsteroidMovement
extends Node2D

export var speed = 150
var SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/height")
var edge_disappear_point = SCREEN_HEIGHT + 50
onready var manager = get_tree().root.get_node("Main/Game") as GameManager

func _physics_process(delta):
	position.y += speed * delta
	if position.y >= edge_disappear_point:
		# Asteroid passed screen edge
		if manager: manager.update_score(-50)
		queue_free()

func explode():
	$Graphic.queue_free()
	$Collider.queue_free()
	$Particles2D.emitting = true
	speed = 0
	$Timer.connect("timeout", self, "queue_free")
	$Timer.wait_time = $Particles2D.lifetime;
	$Timer.start()
	if manager: manager.update_score(10)
