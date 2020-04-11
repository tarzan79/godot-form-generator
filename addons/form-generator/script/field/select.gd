extends HBoxContainer

var value setget _set_value, _get_value
onready var label = $Label.text

func init(data):
    if data.has("label"):
        $Label.text = data.label
    if data.has("value"):
        for i in data.value:
            $OptionButton.add_item(i)


func _get_value():
    var res = $OptionButton.get_item_text($OptionButton.selected)
    return res
    
func _set_value(v):
    value = v
