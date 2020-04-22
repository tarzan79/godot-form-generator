tool
extends PanelContainer
class_name Form

export var form_data = []
#onready var label = $Form/Label.text

var field = load("res://addons/form-generator/script/field.gd").new()
var scene_form = load("res://addons/form-generator/scene/form.tscn")
onready var btn_submit = $Submit
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
    scene_instance.get_node("Submit").connect("pressed", self, "_submit")
    
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

#les 3 fonctions suivante sont la a cause du coté recursif des fonctions
func from_data(data):
    generator_from_data(form_node, data)

func from_schema(data):
    generator_from_schema(form_node, data)

func from_resource(data):
    print("from resource")
    generator_from_resource(form_node, data)

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
            TYPE_REAL:
                obj["rounded"] = false
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
func generator_from_resource(node, data):
    print("generate from resource")
    form_data = []
    for prop in data.get_property_list():
        if prop["usage"] >= PROPERTY_USAGE_SCRIPT_VARIABLE:
            var obj = {
                "label": prop["name"], 
                "value": data.get(prop["name"]), 
                "type": prop["type"],
                "hint": prop["hint"],
                "hint_string": prop["hint_string"],
                "editor": is_editor
                }
            match prop["type"]:
                TYPE_BOOL:
                    node.add_child(field.create_checkbutton(obj))
                TYPE_INT:
                    match prop["hint"]:
                        3:
                            node.add_child(field.create_select(obj))
                        _:
                            node.add_child(field.create_number(obj))
                TYPE_REAL:
                    obj["rounded"] = false
                    node.add_child(field.create_number(obj))
                TYPE_STRING:
                    match prop["hint"]:
                        PROPERTY_HINT_ENUM:
                            print("create_select 1")
                            node.add_child(field.create_select(obj))#name, value
                        PROPERTY_HINT_FILE:
                            node.add_child(field.create_file(obj))
                        PROPERTY_HINT_DIR:
                            node.add_child(field.create_file(obj))
                        PROPERTY_HINT_MULTILINE_TEXT:
                            node.add_child(field.create_multiline(obj))
                TYPE_VECTOR2:
                    node.add_child(field.create_vector2(obj))
                TYPE_VECTOR3:
                    node.add_child(field.create_vector3(obj))
                TYPE_COLOR:
                    node.add_child(field.create_color(obj))
#                TYPE_DICTIONARY:
#                    var f = field.create_fieldset(obj)
#                    node.add_child(f)
#                    generator_from_data(f.get_node("VBoxContainer/VBoxContainer"), data[prop])
                TYPE_RECT2:
                    pass
                TYPE_NODE_PATH:
                    pass
#                TYPE_ARRAY:
#                    var f = field.create_fieldset(obj)
#                    node.add_child(f)
#                    generator_from_data(f.get_node("VBoxContainer/VBoxContainer"), data[prop])
#                TYPE_INT_ARRAY:
#                    pass
#                TYPE_REAL_ARRAY:
#                    pass
#                TYPE_STRING_ARRAY:
#                    pass
#                TYPE_VECTOR2_ARRAY:
#                    pass
#                TYPE_VECTOR3_ARRAY:
#                    pass
#                TYPE_COLOR_ARRAY:
#                    pass
#                TYPE_INT_ARRAY:
#                    pass
                _: print("je connais pas ce truc")

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
