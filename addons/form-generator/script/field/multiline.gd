extends HBoxContainer

class_name FieldMultiline

onready var value = $TextEdit.text
onready var label = $Label.text

func _ready():
    pass

func init(data):
    if data.has("label"):
        $Label.text = data.label
    if data.has("value"):
        $TextEdit.text = data.value   
    pass
