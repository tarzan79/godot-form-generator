extends HBoxContainer

class_name FieldInput

var regex = RegEx.new()
var type
onready var value = $LineEdit.text
onready var label = $Label.text
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

func validate(data):
    var result = regex.search(data)
    if result:
        print(result.get_string())
    else:
        print("pas trouvé")
    
    
    
