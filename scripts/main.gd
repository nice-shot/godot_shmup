extends Node


var main_menu = preload("res://scenes/menu.tscn")
var game = preload("res://scenes/game.tscn")

var menu_node : Node

func _ready():
    menu_node = main_menu.instance()
    var error = menu_node.connect("menu_clicked", self, "_on_menu_clicked")
    if (error):
        print("Couldn't connect 'menu_clicked' event")
    add_child(menu_node)

func _on_menu_clicked(var id:int):
    print("Got menu index: %s" % id)
    var game_node = game.instance()
    menu_node.queue_free()
    add_child((game_node))
    
