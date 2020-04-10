extends Node


var main_menu = preload("res://scenes/menu.tscn")
var game = preload("res://scenes/game.tscn")
var leaderboard = preload("res://scenes/leaderboard.tscn")

const SAVE_DATA_PATH = "user://local.data"

var menu_node : Node

func _ready():
    menu_node = main_menu.instance()
    menu_node.connect("menu_clicked", self, "_on_menu_clicked")
    add_child(menu_node)

func _on_menu_clicked(var id:int):
    if (id == 0):
        var game_node = game.instance()
        menu_node.queue_free()
        add_child((game_node))
    else:
        var leaderboard_node = leaderboard.instance()
        menu_node.queue_free()
        add_child(leaderboard_node)
