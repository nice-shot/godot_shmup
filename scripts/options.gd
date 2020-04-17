extends Node

var _volume_steps = {
    0: -72,
    1: -30,
    2: -20,
    3: -10,
    4: -5,
    5: 0
}

func _on_volume_change(value: int) -> void:
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), _volume_steps[value])
    get_parent().get_node("SFX").play()
