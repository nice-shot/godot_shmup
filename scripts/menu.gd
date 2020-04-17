extends Node

onready var _previous_menu_btn : Control = $Main/PlayBTN


func _ready() -> void:
    set_screen_main()
    # Set SelectSFX for button switching
    for button in _get_nodes_of_type(Button, self):
        button.connect("focus_entered", $SFX, "play")


func _get_nodes_of_type(type, root : Node) -> Array:
    var nodes := []
    for n in root.get_children():
        nodes.append(n)
        for sub_n in _get_nodes_of_type(type, n):
            nodes.append(sub_n)
    return nodes


func play() -> void:
    get_tree().change_scene("res://scenes/game.tscn")


func set_screen_main() -> void:
    $Main.show()
    _previous_menu_btn.grab_focus()
    $Leaderboard.hide()


func set_screen_leaderboard() -> void:
    $Leaderboard.show()
    $Leaderboard/BackBTN.grab_focus()
    $Main.hide()
    _previous_menu_btn = $Main/LeaderboardBTN


func set_screen_options() -> void:
    return
    $Main.hide()
    $Leaderboard.hide()
    _previous_menu_btn = $Main/OptionsBTN
