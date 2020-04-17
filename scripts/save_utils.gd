class_name SaveUtils

const SAVE_DATA_PATH := "user://local.data"


static func _create_default_data() -> Dictionary:
    var leaderboard = []
    for i in range(10):
        leaderboard.append({ score = 0, name = "???" })
    
    return { leaderboard = leaderboard }


static func _validate() -> bool:
    var save_file = File.new()
    if not save_file.file_exists(SAVE_DATA_PATH): return false
    
    save_file.open(SAVE_DATA_PATH, File.READ)
    var parse_results := JSON.parse(save_file.get_as_text())
    if parse_results.error != OK: return false
    
    var data = parse_results.result
    if not data is Dictionary: return false
    
    if not "leaderboard" in data: return false
    
    var leaderboard = data.leaderboard
    if not leaderboard is Array: return false
    
    for entry in leaderboard:
        if not entry is Dictionary: return false
        if not "name" in entry: return false
        if not "score" in entry: return false
    
    return true


static func load_save_data() -> Dictionary:
    if not _validate():
        save_data(_create_default_data())
        
    var save_file = File.new()            
    save_file.open(SAVE_DATA_PATH, File.READ)
    print("Loading save data: %s" % save_file.get_path_absolute())
    var data : Dictionary = parse_json(save_file.get_as_text())
    
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
    
