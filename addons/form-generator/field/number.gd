extends HBoxContainer

onready var value = $SpinBox.value
onready var label = $Label.text

func init(data):
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
