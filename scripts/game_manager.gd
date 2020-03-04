class_name GameManager
extends Node

var score = 0
onready var score_text = $ScoreLabel

func update_score(points):
	score += points
	score_text.text = "Score: %d" % score
	
func _ready():
	update_score(0)
