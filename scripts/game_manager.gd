extends Node

var _score := 0
onready var _score_text : Label = $ScoreLabel


func _ready() -> void:
    _update_score(0)
    var error = $Ship.connect("destroyed", self, "_on_ship_destroyed")
    if (error):
        print("Couldn't connect ship 'destroyed' event")


func _update_score(points : int) -> void:
    # Don't change score if we're dead
    if $DeathMessage.visible: return
    _score += points
    _score_text.text = "Score: %d" % _score


func _on_ship_destroyed() -> void:
    # Hide Ship and prevent collisions
    $Ship.queue_free()
    # Don't spawn additional asteroids
    $AsteroidSpawner.stop()
    # Show death menu
    $DeathMessage.visible = true
    var death_label : Label = $DeathMessage/DeathMessageLabel
    death_label.text = death_label.text.replace("###", str(_score))
    $DeathMessage/EnterName.grab_focus()


func _on_bullet_exit_screen() -> void:
    _update_score(-5)


func _on_asteroid_destroyed() -> void:
    _update_score(10)


func _on_asteroid_exit_screen() -> void:
    _update_score(-50)


func _upload_score() -> void:
    if SaveUtils.add_score($DeathMessage/EnterName.text, _score):
        print("Added score - %d - to leaderboard!" % _score)
    else:
        print("New score - %d - not high enough for leaderboard" % _score)


func _on_retry() -> void:
    _upload_score()
    get_tree().reload_current_scene()


func _on_back() -> void:
    _upload_score()
    get_tree().change_scene("res://scenes/menu.tscn")
