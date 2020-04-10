extends Node


var main_menu = preload("res://scenes/menu.tscn")
var game = preload("res://scenes/game.tscn")

const SAVE_DATA_PATH = "user://local.data"

var menu_node : Node
var leaderboard = []

func _ready():
    menu_node = main_menu.instance()
    menu_node.connect("menu_clicked", self, "_on_menu_clicked")
    add_child(menu_node)

func _on_menu_clicked(var id:int):
    var game_node = game.instance()
    menu_node.queue_free()
    add_child((game_node))
