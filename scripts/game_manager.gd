class_name GameManager
extends Node

var score = 0
onready var score_text = $ScoreLabel

func update_score(points):
    score += points
    score_text.text = "Score: %d" % score
    
func _ready():
    update_score(0)
    var error = $Ship.connect("hit", self, "_on_hit")
    if (error):
        print("Couldn't connect ship 'hit' event")
    
func _on_hit():
    get_tree().paused = true
    $DeathMessage.visible = true
    $DeathMessage/DeathMessageLabel.text = $DeathMessage/DeathMessageLabel.text.replace("###", score)
    $DeathMessage/EnterName.grab_focus()
    var error = $DeathMessage.connect("finished", self, "_on_continue")
    if (error):
        print("Couldn't connect 'finished' game manager 'finished' event")

func _on_continue():
    get_tree().paused = false
    score = 0
    $DeathMessage.visible = false
    $DeathMessage.disconnect("finished", self, "_on_continue")
    
    
