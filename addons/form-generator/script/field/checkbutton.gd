extends HBoxContainer


onready var label = $Label.text
onready var value = $CheckButton.pressed

func _ready():
    pass

func init(data):
    if data.has("value"):
        $CheckButton.pressed = bool(data.value)
    if data.has("label"):
        $Label.text = data.label
