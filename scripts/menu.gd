extends Node

onready var _previous_menu_btn : Control = $Main/PlayBTN


func _ready() -> void:
    set_screen_main()


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
