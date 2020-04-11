extends Resource

#pour un input, on definira le type plus tard
#il y a deja un hidden sur les node, donc on le gere comme ca
#bouton radio, range
var ClassButton = load("res://addons/form-generator/scene/button.tscn")
var ClassCheckBox = load("res://addons/form-generator/scene/field/checkbox.tscn")
var ClassColorPicker = load("res://addons/form-generator/scene/field/colorPicker.tscn")
var ClassDate = load("res://addons/form-generator/scene/field/date.tscn")
var ClassFile = load("res://addons/form-generator/scene/field/file.tscn")
var ClassImage = load("res://addons/form-generator/scene/field/image.tscn")
var ClassInput = load("res://addons/form-generator/scene/field/input.tscn")
var ClassLabel = load("res://addons/form-generator/scene/label.tscn")
var ClassLink = load("res://addons/form-generator/scene/link.tscn")
var ClassSelect = load("res://addons/form-generator/scene/field/select.tscn")
var ClassNumber = load("res://addons/form-generator/scene/field/number.tscn")
var ClassFieldset = load("res://addons/form-generator/scene/fieldset.tscn")
var ClassVector2 = load("res://addons/form-generator/scene/field/vector2.tscn")
var ClassVector3 = load("res://addons/form-generator/scene/field/vector3.tscn")

func _init():
    pass

#text, url, tel, password, email
func create_input(data):
    var field = ClassInput.instance()
    field.init(data)
    return field
    
func create_number(data):
    var field = ClassNumber.instance()
    field.init(data)
    return field
    
#checkbox, radio
func create_checkbox():
    pass
    
#option (list)
func create_select(data):
    var field = ClassSelect.instance()
    field.init(data)
    return field
    
#color
func create_color(data):
    var field = ClassColorPicker.instance()
    field.init(data)
    return field
    
func create_label():
    pass
    
#clickable link    
func create_link():
    pass
    
#button, reset, submit
func create_button(data):
    var field = ClassButton.instance()
    field.init(data)
    return field

#file
func create_file():
    pass
    
func create_date():
    pass
    
func create_image():
    pass

func create_fieldset(data):
    var field = ClassFieldset.instance()
    field.init(data)
    return field
    
func create_vector2(data):
    var field = ClassVector2.instance()
    field.init(data)
    return field

func create_vector3(data):
    var field = ClassVector3.instance()
    field.init(data)
    return field
