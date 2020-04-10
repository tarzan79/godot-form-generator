extends HBoxContainer

onready var value = $SpinBox.value
onready var label = $Label.text
var editor = false setget _set_editor

func init(data):
    $Control.hide()
    $Control/PanelContainer/VBoxContainer/Button.connect("pressed", self, "_hide_config")
    value = $SpinBox.value
    var spinbox = $SpinBox
    
    if data.has("label"):
        $Label.text = data.label
        
    if data.has("value"):
        spinbox.value = data.value
        
    if data.has("rounded") && data.rounded == true:
        spinbox.step = 1
        spinbox.rounded = true
    else:
        spinbox.step = 0.1
        spinbox.rounded = false
        
    if data.has("schema"):
        if data.schema.has("readOnly"):
            $SpinBox.editable = false

    if data.has("editor"):
        _set_editor(data.editor)
          
func _set_editor(val):
    editor = val
    if editor == true:
        $EditButton.show()
        $EditButton.connect("pressed", self, "_show_config")
    elif editor == false:
        $EditButton.hide()
        $EditButton.disconnect("pressed", self, "_show_config")
        
func _show_config():
    $Control.show()

func _hide_config():
    $Control.hide()
