extends HBoxContainer

var value setget _set_value, _get_value
onready var label = $Label.text
var index = 0
var type = "string"

func init(data):
    print("data select")
    print(data)
    if data.has("label"):
        $Label.text = data.label
    # si c'est un export, sans cette condition, ca provoque un conflit avec le mode "generate_from_data"
    if data.has("hint_string"):
        if data.type == TYPE_INT:
            type = "int"
            for item in data.hint_string.split(","):
                var sub_item = item.split(":")    
                if sub_item.size() == 1: 
                    # gestion de ce cas: {class_name:, hint:3, hint_string:Warrior,Magician,Thief, name:character_class, type:2, usage:8199}
                    index += 1
                    $OptionButton.add_item(sub_item[0], index)
                else: 
                    # gestion de ce cas: {class_name:, hint:3, hint_string:Popo:0,Pipi:1,Caca:-1, name:x, type:2, usage:8199}
                    $OptionButton.add_item(sub_item[0], int(sub_item[1]))
        else:
            for item in data.hint_string.split(","):
                print(item)
                $OptionButton.add_item(item)
    elif data.has("value"): # si c'est juste une variable
        print("value " + str(data.value))
        for i in data.value:
            $OptionButton.add_item(i)


func _get_value():
    var res
    if type == "string":
        res = $OptionButton.get_item_text($OptionButton.selected)
    else: # donc si c'est un int
        res = $OptionButton.selected
    return res
    
func _set_value(v):
    value = v
