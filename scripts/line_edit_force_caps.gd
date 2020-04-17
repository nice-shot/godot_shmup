extends LineEdit


func _ready():
    connect("text_changed", self, "_validate_text")
    
func _validate_text(new_text : String):
    if new_text == new_text.to_upper():
        return
    
    # caret_position resets when setting text via code
    var p = caret_position
    text = new_text.to_upper()
    caret_position = p
