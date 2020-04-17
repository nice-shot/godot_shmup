class_name GameManager
extends Node

var score = 0
onready var score_text = $ScoreLabel
var highscore = ["???", 0]

const SAVE_DATA_PATH = "user://local.data"

signal ended

func update_score(points : int):
    # Don't change score if we're dead
    if $DeathMessage.visible: return
    score += points
    score_text.text = "Score: %d" % score

func _ready():
    update_score(0)
    var error = $Ship.connect("destroyed", self, "_on_ship_destroyed")
    if (error):
        print("Couldn't connect ship 'destroyed' event")


func _on_ship_destroyed():
    # Hide Ship and prevent collisions
    $Ship.visible = false
    $Ship/Collider/CollisionPolygon.set_deferred("disabled", true)
    # Don't spawn additional asteroids
    $AsteroidSpawner.stop()
    # Show death menu
    $DeathMessage.visible = true
    $DeathMessage/DeathMessageLabel.text = $DeathMessage/DeathMessageLabel.text.replace("###", score)
    $DeathMessage/EnterName.grab_focus()


func _on_bullet_exit_screen():
    update_score(-5)

func _on_asteroid_destroyed():
    update_score(10)

func _on_asteroid_exit_screen():
    update_score(-50)

func _upload_score():
    emit_signal("ended", $DeathMessage/EnterName.text, score)

func _on_retry():
    _upload_score()
    get_tree().reload_current_scene()

func _on_back():
    _upload_score()
    get_tree().change_scene("res://scenes/menu.tscn")


#func _load_score():
#    var save_file = File.new()
#    if not save_file.file_exists(SAVE_DATA_PATH):
#        print("No data file found")
#        return
#    save_file.open(SAVE_DATA_PATH, File.READ)
#    print("Loading file: %s" % save_file.get_path_absolute())
#    highscore = parse_json(save_file.get_line())
#    print("Got high score: " + str(highscore))
#    save_file.close()
#
#func _save_score():
#    var save_file = File.new()
#    save_file.open(SAVE_DATA_PATH, File.WRITE)
#    save_file.store_line(to_json(highscore))
#    save_file.close()
#    print("Saving leaderboard: " + str(highscore))
