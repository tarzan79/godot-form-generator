tool
extends PanelContainer
class_name Form

export var form_data = []
#onready var label = $Form/Label.text

var field = load("res://addons/form-generator/field.gd").new()
var scene_form = load("res://addons/form-generator/form.tscn")
var scene_instance
var is_editor = false setget _set_editor, _get_editor
var node_origin
var form_node
var function

func _ready():
    scene_instance = scene_form.instance()
    add_child(scene_instance)
    form_node = scene_instance.get_node("Content")
    print(scene_instance)
    
func init(data):
    if !data.has("node"):
        print("il faut un node")
        return false
    if !data.has("function"):
        print("il faut une fonction")
        return false  
    if data.has("editor"):
        _set_editor(data.editor)
    if data.has("name"):
        $Form/Label.text = data.name
    function = data.function
    node_origin = data.node

func from_data(data):
    generator_from_data(form_node, data)
    var ok = field.create_button({
        "type": "submit",
        "value": "envoyer"
       })
    ok.connect("pressed", self, "_submit")
    form_node.add_child(ok)
    
func from_schema(data):
    generator_from_schema(form_node, data)
    var ok = field.create_button({
        "type": "submit",
        "value": "envoyer"
       })
    ok.connect("pressed", self, "_submit")
    form_node.add_child(ok)

func _reset():
    _reset_data(form_node)

func _submit():
    var res = _get_data(form_node)
    print(res)
#    node_origin.call(function, res)
    
func _get_data(node):
    print("submit")
    var res = {}
    for n in node.get_children():
        if not n is Button:
            res[n.label] = n.value    
    return res

func _reset_data(node):
    print("submit")
    var res = {}
    for n in node.get_children():
        if not n is Button:
            res[n.label] = ""   
    return res
    
#string
#int
#color
#vector2
#vector3
#dictionnary
#array
func generator_from_data(node, data):
    print(node)
    form_data = []
    for i in data:
        var obj = {"label": i, "value": data[i], "editor": is_editor}
        match typeof(data[i]):
            TYPE_STRING:
                node.add_child(field.create_input(obj))#name, value
            TYPE_INT:
                node.add_child(field.create_number(obj))#name, value
            TYPE_COLOR:
                node.add_child(field.create_color(obj))#name, value
                pass
            TYPE_VECTOR2:
                node.add_child(field.create_vector2(obj))#name, value
            TYPE_VECTOR3:
                node.add_child(field.create_vector3(obj))#name, value
            TYPE_DICTIONARY:
                var f = field.create_fieldset(obj)
                node.add_child(f)#name, value
                generator_from_data(f.get_node("VBoxContainer/VBoxContainer"), data[i])
            TYPE_ARRAY:
                node.add_child(field.create_select(obj))#name, value
            _: print("je connais pas ce truc") 

#string
#number
#integer
#boolean
#null
func generator_from_schema(node, data):
    for i in data["properties"]:
        var noeud
        print(i)
        print(data["properties"][i].type)
        var obj = {"label": i, "schema": data["properties"][i], "editor": is_editor}
        match data["properties"][i].type:
            "string":
                node.add_child(field.create_input(obj))#name, value
            "number":
                node.add_child(field.create_number(obj))#name, value
            "integer":
                node.add_child(field.create_number(obj))#name, value
            "array":
                node.add_child(field.create_select(obj))#name, value
            "object":
                var f = field.create_fieldset(obj) # name, value
                node.add_child(f)#name, value
                generator_from_schema(f.get_node("VBoxContainer/VBoxContainer"), data["properties"][i])
#            "boolean":
#                pass
        

func _set_editor(value):
    is_editor = value
    print("============")
    print(scene_instance)
    if is_editor == true:
        scene_instance.get_node("HBoxContainer").show()
    elif is_editor == false:
        scene_instance.get_node("HBoxContainer").hide()
    
func _get_editor():
    return is_editor
