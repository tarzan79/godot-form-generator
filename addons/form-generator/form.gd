extends Node

class_name Form
#[ ]TYPE_NIL = 0 — Variable is null.
#[ ]TYPE_BOOL = 1 — Variable is of type bool.
#[x]TYPE_INT = 2 — Variable is of type int.
#[ ]TYPE_REAL = 3 — Variable is of type float (real).
#[x]TYPE_STRING = 4 — Variable is of type String.
#[ ]TYPE_VECTOR2 = 5 — Variable is of type Vector2.
#[ ]TYPE_RECT2 = 6 — Variable is of type Rect2.
#[ ]TYPE_VECTOR3 = 7 — Variable is of type Vector3.
#[ ]TYPE_TRANSFORM2D = 8 — Variable is of type Transform2D.
#[ ]TYPE_PLANE = 9 — Variable is of type Plane.
#[ ]TYPE_QUAT = 10 — Variable is of type Quat.
#[ ]TYPE_AABB = 11 — Variable is of type AABB.
#[ ]TYPE_BASIS = 12 — Variable is of type Basis.
#[ ]TYPE_TRANSFORM = 13 — Variable is of type Transform.
#[x]TYPE_COLOR = 14 — Variable is of type Color.
#[ ]TYPE_NODE_PATH = 15 — Variable is of type NodePath.
#[ ]TYPE_RID = 16 — Variable is of type RID.
#[ ]TYPE_OBJECT = 17 — Variable is of type Object.
#[x]TYPE_DICTIONARY = 18 — Variable is of type Dictionary.
#[x]TYPE_ARRAY = 19 — Variable is of type Array.
#[ ]TYPE_RAW_ARRAY = 20 — Variable is of type PoolByteArray.
#[ ]TYPE_INT_ARRAY = 21 — Variable is of type PoolIntArray.
#[ ]TYPE_REAL_ARRAY = 22 — Variable is of type PoolRealArray.
#[ ]TYPE_STRING_ARRAY = 23 — Variable is of type PoolStringArray.
#[ ]TYPE_VECTOR2_ARRAY = 24 — Variable is of type PoolVector2Array.
#[ ]TYPE_VECTOR3_ARRAY = 25 — Variable is of type PoolVector3Array.
#[ ]TYPE_COLOR_ARRAY = 26 — Variable is of type PoolColorArray.
#[ ]TYPE_MAX = 27 — Represents the size of the Variant.Type enum.

var field = load("res://addons/form-generator/field.gd").new()
var editor #true/false
var node_origin
var form_node
var form_data = []
var function

func _init(data):
    if !data.has("node"):
        print("il faut un node")
        return false
    
    if !data.has("function"):
        print("il faut une fonction")
        return false
        
    if data.has("editor"):
        editor = data.editor
    
    function = data.function
    node_origin = data.node
    form_node = VBoxContainer.new()
    node_origin.add_child(form_node)

func create_form(data):
    generator_from_data(form_node, data)
    
    var ok = field.create_button({
        "type": "submit",
        "value": "envoyer"
       })
    ok.connect("pressed", self, "_submit")
    form_node.add_child(ok)

func generator_from_data(node, data):
    form_data = []
    for i in data:
        match typeof(data[i]):
            TYPE_STRING:
                node.add_child(field.create_input({"label": i, "value": data[i]}))#name, value
            TYPE_INT:
                node.add_child(field.create_number({"label": i, "value": data[i]}))#name, value
            TYPE_COLOR:
                node.add_child(field.create_color({"label": i, "value": data[i]}))#name, value
                pass
            TYPE_VECTOR2:
                node.add_child(field.create_vector2({"label": i, "value": data[i]}))#name, value
            TYPE_VECTOR3:
                node.add_child(field.create_vector3({"label": i, "value": data[i]}))#name, value
            TYPE_DICTIONARY:
                var f = field.create_fieldset({"label": i, "value": data[i], "editor": editor})
                node.add_child(f)#name, value
                generator_from_data(f.get_node("VBoxContainer2/VBoxContainer"), data[i])
            TYPE_ARRAY:
                node.add_child(field.create_select({"label": i, "value": data[i]}))#name, value
            _: print("je connais pas ce truc") 

func generator_from_schema(data):
    for i in data:
        var noeud
        match i.field:
            "input": form_node.add_child(field.create_input(i))
            "button": 
                var button = field.create_button(i)
                if i.type == "reset": button.connect("pressed", self, "_reset")
                if i.type == "submit": button.connect("pressed", self, "_submit")
                form_node.add_child(button) 

func _reset():
    _reset_data(form_node)

func _submit():
    var res = _get_data(form_node)
    node_origin.call(function, res)
    
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
