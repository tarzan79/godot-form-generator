extends HBoxContainer

class_name FieldInput

var input_config_scene = load("res://addons/form-generator/scene/config/input_config.tscn")
onready var value = $LineEdit.text
onready var label = $Label.text
var input_config_instance
var regex = RegEx.new()
var type
var editor = false setget _set_editor

var pattern = {
    "active": false,
    "value": ""
   }
var min_length = {
    "active": false,
    "value": 0
   }
var max_length = {
    "active": false,
    "value": 0
   }


#text, url, tel, password, email
func init(data):
    if data.has(type):
        match type:
            "text":
                pass
            "url":
                pass
            "tel":
                regex.compile("^((\\+)33|0)[1-9](\\d{2}){4}$")
            "password":
                $LineEdit.secret = true
            "email":
                regex.compile("[^@]+@[^\\.].+")
            _:
                print("default")
    if data.has("label"):
        $Label.text = data.label
    if data.has("value"):
        $LineEdit.text = data.value
    if data.has("schema"):
        if data.schema.has("readOnly"):
            $LineEdit.editable = false
            pass
    if data.has("editor"):
        _set_editor(data.editor)
        

func validate(data):
    var result = regex.search(data)
    if result:
        print(result.get_string())
    else:
        print("pas trouvé")

func _set_editor(val):
    editor = val
    if editor == true:
        $EditButton.show()
        $EditButton.connect("pressed", self, "_show_config")
    elif editor == false:
        $EditButton.hide()
        $EditButton.disconnect("pressed", self, "_show_config")
        
func _show_config():
    input_config_instance = input_config_scene.instance()
    input_config_instance.get_node("VBoxContainer/Button").connect("pressed", self, "_hide_config")
    input_config_instance.rect_position = $EditButton.rect_position - Vector2(150, 0)
    get_parent().get_parent().get_node("Popup").add_child(input_config_instance)

func _hide_config():
    input_config_instance.queue_free()
