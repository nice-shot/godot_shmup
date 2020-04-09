class_name GameManager
extends Node

var score = 0
onready var score_text = $ScoreLabel

func update_score(points):
    score += points
    score_text.text = "Score: %d" % score
    
func _ready():
    update_score(0)
    $Ship.connect("hit", self, "_on_hit")
    
func _on_hit():
    get_tree().paused = true
    $DeathMessage.visible = true
    $DeathMessage/DeathMessageLabel.text = $DeathMessage/DeathMessageLabel.text.replace("###", score)
    $DeathMessage/EnterName.grab_focus()
    $DeathMessage.connect("finished", self, "_on_continue")

func _on_continue():
    get_tree().paused = false
    score = 0
    $DeathMessage.visible = false
    $DeathMessage.disconnect("finished", self, "_on_continue")
    
    
