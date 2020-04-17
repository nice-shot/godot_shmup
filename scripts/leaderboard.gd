extends Control


func _ready() -> void:
    var data = SaveUtils.load_save_data()
    for i in range(data.leaderboard.size()):
        var entry : Dictionary = data.leaderboard[i]
        var label : Label = $VBoxContainer.get_child(i)
        label.text = "%d - %s - %d" % [i + 1, entry.name, entry.score]
