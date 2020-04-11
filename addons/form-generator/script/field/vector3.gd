extends HBoxContainer

var value:Vector3 = Vector3(0, 0, 0) setget _set_value, _get_value
onready var label = $Label.text

func init(data):
    if data.has("label"):
        $Label.text = data.label
    if data.has("value"):
        $VBoxContainer/LineEdit.text = str(data.value.x)
        $VBoxContainer/LineEdit2.text = str(data.value.y)
        $VBoxContainer/LineEdit3.text = str(data.value.z)

func _set_value(vect):
    value = vect
    pass
    
func _get_value():
    value.x = int($VBoxContainer/LineEdit.text)
    value.y = int($VBoxContainer/LineEdit2.text)
    value.z = int($VBoxContainer/LineEdit3.text)
    return value
