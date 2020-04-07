extends Control

onready var label = $Label.text
onready var value = $CheckBox.pressed

func init(data):
    if data.has("label"):
        $Label.text = data.label
    if data.has("value"):
        $CheckBox.pressed = data.value
