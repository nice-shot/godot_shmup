class_name SaveUtils

const SAVE_DATA_PATH = "user://local.data"

static func load_save_data() -> Array:
    var save_file = File.new()
    if not save_file.file_exists(SAVE_DATA_PATH):
        print("No save data found")
        return []
    save_file.open(SAVE_DATA_PATH, File.READ)
    print("Loading save data: %s" % save_file.get_path_absolute())
    var data = parse_json(save_file.get_as_text())
    save_file.close()
    return data

static func save_data(data : Array):
    var save_file = File.new()
    save_file.open(SAVE_DATA_PATH, File.WRITE)
    print("Writing save data: %s to %s" % [data, save_file.get_path_absolute()])
    save_file.store_string(to_json(data))
    save_file.close()

# Adds the score if its in the top 10
# Returns false if the score didn't enter
static func add_score(name: String, score: int) -> bool:
    var scores : Array = load_save_data()
    if scores.size() == 0:
        scores.append({name: name, score: score})
        return true
    
    for i in range(scores.size()):
        var s = scores[i]
        if (score > s.score):
            scores.insert(i, { name: name, score: score })
            if (scores.size() > 10):
                scores.remove(10)
            return true
    return false
    
