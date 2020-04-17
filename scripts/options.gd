extends Node

var _volume_steps = [-72, -30, -20, -10, -5, 0]

const MASTER_BUS := "Master"


func _ready() -> void:
    var step: int = _get_bus_volume_step(MASTER_BUS)
    var slider: Slider = $VolumeCTRL/VolumeSlider
    if step != slider.value:
        slider.value = step


func _get_bus_volume(bus: String) -> float:
    return AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus))


func _set_bus_volume(bus: String, volume: float) -> void:
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), volume)


func _get_bus_volume_step(bus: String) -> int:
    var bus_volume: float = _get_bus_volume(bus)
    for i in range(_volume_steps.size()):
        var val: int = _volume_steps[i]
        if bus_volume <= val:
            return i
    # Returns 0 db value
    return _volume_steps.size() - 1


func _on_volume_change(value: int) -> void:
    _set_bus_volume(MASTER_BUS, _volume_steps[value])
    get_parent().get_node("SFX").play()
