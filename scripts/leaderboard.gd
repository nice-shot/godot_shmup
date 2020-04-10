class_name Leaderboard
extends Control

var _score_label = preload("res://scenes/score_label.tscn")
onready var _scores_container = $Scores

func _ready():
    display_scores()

func display_scores() -> void:
    var scores = SaveUtils.load_save_data()
    print(scores)
    
