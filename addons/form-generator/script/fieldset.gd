extends PanelContainer

var field = load("res://addons/form-generator/script/field.gd").new()
var form = load("res://addons/form-generator/script/form.gd")
var value = {} setget _set_value, _get_value
onready var label = $VBoxContainer/Label.text

func _ready():
    pass
    
func init(data):
    print("fieldset")
    print(data)
    if data.has("editor"):
        $VBoxContainer/Button.hide()
    if data.has("label"):
        $VBoxContainer/Label.text = data.label
    if data.has("type"):
        match data.type:
            TYPE_ARRAY:
                print("araaaaaaaay")
                print(data.value)
                var f = field.create_fieldset(data.value)
                $VBoxContainer/VBoxContainer.add_child(f)
                #form.generator_from_data(f.get_node("VBoxContainer/VBoxContainer"), data[value])
#            TYPE_INT_ARRAY:
#                pass
#            TYPE_REAL_ARRAY:
#                pass
#            TYPE_STRING_ARRAY:
#                pass
#            TYPE_VECTOR2_ARRAY:
#                pass
#            TYPE_VECTOR3_ARRAY:
#                pass
#            TYPE_COLOR_ARRAY:
#                pass
#            TYPE_INT_ARRAY:
#                pass

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
