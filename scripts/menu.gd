extends Node

var _selected_index = 0
onready var _selections = [$PlaySelectionArrows, $LeaderboardSelectionArrows]

signal menu_clicked

func _ready():
    for selection in _selections:
        (selection as Node2D).hide()
    
    _selections[_selected_index].show()

func _input(event):
    var new_index:int = _selected_index
    if event.is_action_pressed("ui_down"):
        new_index += 1
    elif event.is_action_pressed("ui_up"):
        new_index -= 1
    
    if _selected_index != new_index:
        _selections[_selected_index].hide()
        _selected_index = new_index % len(_selections)
        _selections[_selected_index].show()
    
    if event.is_action_pressed("ui_accept"):
        # Emitting signal on defered so the ship won't immediately shoot
        call_deferred("_emit_menu_clicked")

func _emit_menu_clicked():
    emit_signal("menu_clicked", _selected_index)
        
