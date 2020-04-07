extends Node

var field = load("res://addons/form-generator/field.gd").new()

func _ready():
    var a = Form.new({
        "node": self,
        "editor": true,
        "function": "truc"
        })
    a.create_form({
        "pseudo": "severin",
        "age": 18,
        "un vecteur": Vector2(0, 3),
        "un autre vecteur": Vector3(0, 3, 5),
        "couleur": Color(1,1,1),
        "un truc": ["uiuiui", "popopop", "fufufu"],
        "un objet": {
            "name": "je sais pas quoi mettre",
            "date": "01/01/1000"
           }
        })

func truc(data):
    print(data)
