extends Button

#button, reset, submit
var regex = ""
enum type_enum {button, reset, submit}
export(type_enum) var type
var value = null

func init(data):
    type = data.type
    match type:
        "button":
            pass
        "reset":
            pass
        "submit":
            text = data.value
        _:
            print("default 2")
    if data.has("value"):
        text = data.value

func validate():
    print(get_parent())
    pass
    
    
    
