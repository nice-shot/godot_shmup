class_name SaveUtils


var _default_data := {
    leaderboard = [
        { score = 0, name = "???" }
       ]
   }
const SAVE_DATA_PATH := "user://local.data"

static func _create_default_data() -> Dictionary:
    var leaderboard = []
    for i in range(10):
        leaderboard.append({ score = 0, name = "???" })
    
    return { leaderboard = leaderboard }


static func load_save_data() -> Dictionary:
    var save_file = File.new()
    if not save_file.file_exists(SAVE_DATA_PATH):
        print("Creating default data")
        save_data(_create_default_data())
    # TODO: Validate data?
    save_file.open(SAVE_DATA_PATH, File.READ)
    print("Loading save data: %s" % save_file.get_path_absolute())
    var data = parse_json(save_file.get_as_text())
    save_file.close()
    return data


static func save_data(data : Dictionary) -> void:
    var save_file = File.new()
    save_file.open(SAVE_DATA_PATH, File.WRITE)
    print("Writing save data: %s to %s" % [data, save_file.get_path_absolute()])
    save_file.store_string(to_json(data))
    save_file.close()


# Adds the score if its in the top 10
# Returns false if the score didn't enter
static func add_score(name: String, score: int) -> bool:
    var data : Dictionary = load_save_data()
    var scores : Array = data.leaderboard
    if scores.size() == 0:
        scores.append({name: name, score: score})
        save_data(data)
        return true
    
    for i in range(scores.size()):
        var s = scores[i]
        if (score > s.score):
            scores.insert(i, { name = name, score = score })
            if (scores.size() > 10):
                scores.remove(10)
            save_data(data)
            return true
    
    return false
    
