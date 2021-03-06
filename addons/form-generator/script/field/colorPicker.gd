extends HBoxContainer

var picker
onready var value = $ColorPickerButton.color
onready var label = $Label.text
    
func init(data):
    if data.has("label"):
        $Label.text = data.label
    if data.has("value"):
        $ColorPickerButton.color = data.value
    if data.has("hint") && data.hint == PROPERTY_HINT_COLOR_NO_ALPHA:
        $ColorPickerButton.edit_alpha = false


func _on_ColorPickerButton_color_changed(color):
    value = color
