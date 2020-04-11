extends PanelContainer

var value = {} setget _set_value, _get_value
onready var label = $VBoxContainer/Label.text

func _ready():
    pass
    
func init(data):
    if data.has("editor"):
        $VBoxContainer/Button.hide()
    if data.has("label"):
        $VBoxContainer/Label.text = data.label

func _set_value(data):
    value = data
    
func _get_value():
    return _get_data($VBoxContainer/VBoxContainer)

func _get_data(node):
    var res = {}
    for n in node.get_children():
        if not n is Button:
            res[n.label] = n.value
        
    return res
