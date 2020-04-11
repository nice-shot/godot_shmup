extends Control

signal finished

func _input(event):
    if event.is_action_pressed("ui_accept"):
        emit_signal("finished")
