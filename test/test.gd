extends Node

enum Named {THING_1, THING_2, ANOTHER_THING = -1}
var class_resource_exemple = load("res://test/resource_exemple.gd")

export(Rect2) var truc: Rect2 

func _ready():
    print_hint_of_resource()
    test_from_resource()

func print_hint_of_resource():
    var item = class_resource_exemple.new()
    for property in item.get_property_list():
        if property["usage"] >= PROPERTY_USAGE_SCRIPT_VARIABLE: # if property is
            print(property)


func submit(data):
    print(data)

func test_from_schema():
    var exempleData = {
        "pseudo": "grognon",
        "age": 18,
        "un truc": ["uiuiui", "popopop", "fufufu"],
        "un objet": {
            "name": "je sais pas quoi mettre",
            "date": "01/01/1000"
            }
        }
    var exemple_schema = {
        "$schema": "http://json-schema.org/draft-07/schema",
        "$id": "http://example.com/example.json",
        "type": "object",
        "title": "The Root Schema",
        "description": "The root schema comprises the entire JSON document.",
        "required": [
            "pseudo",
            "age",
            "un truc",
            "un objet"
        ],
        "properties": {
            "pseudo": {
                "$id": "#/properties/pseudo",
                "type": "string",
                "title": "The Pseudo Schema",
                "description": "An explanation about the purpose of this instance.",
                "default": "",
                "readOnly": true,
                "examples": [
                    "grognon"
                ]
            },
            "age": {
                "$id": "#/properties/age",
                "type": "integer",
                "title": "The Age Schema",
                "description": "An explanation about the purpose of this instance.",
                "default": 0,
                "readOnly": true,
                "examples": [
                    18
                ]
            },
            "un truc": {
                "$id": "#/properties/un truc",
                "type": "array",
                "title": "The Un truc Schema",
                "description": "An explanation about the purpose of this instance.",
                "default": [],
                "items": {
                    "$id": "#/properties/un truc/items",
                    "type": "string",
                    "title": "The Items Schema",
                    "description": "An explanation about the purpose of this instance.",
                    "default": "",
                    "examples": [
                        "uiuiui",
                        "popopop",
                        "fufufu"
                    ]
                }
            },
            "un objet": {
                "$id": "#/properties/un objet",
                "type": "object",
                "title": "The Un objet Schema",
                "description": "An explanation about the purpose of this instance.",
                "default": {},
                "examples": [
                    {
                        "name": "je sais pas quoi mettre",
                        "date": "01/01/1000"
                    }
                ],
                "required": [
                    "name",
                    "date"
                ],
                "properties": {
                    "name": {
                        "$id": "#/properties/un objet/properties/name",
                        "type": "string",
                        "title": "The Name Schema",
                        "description": "An explanation about the purpose of this instance.",
                        "default": "",
                        "examples": [
                            "je sais pas quoi mettre"
                        ]
                    },
                    "date": {
                        "$id": "#/properties/un objet/properties/date",
                        "type": "string",
                        "title": "The Date Schema",
                        "description": "An explanation about the purpose of this instance.",
                        "default": "",
                        "examples": [
                            "01/01/1000"
                        ]
                    }
                }
            }
        }
    }
    var formulaire = Form.new()
    add_child(formulaire)
    formulaire.init({
        "name": "un joli formulaire",
        "node": self, #where generate the form
        "editor": true, #if mode editor is active
        "function": "submit" #function executed for submit
        })
    formulaire.from_schema(exemple_schema)

func test_from_data():
    var formulaire = Form.new()
    add_child(formulaire)
    formulaire.init({
        "name": "un joli formulaire",
        "node": self, #where generate the form
        "editor": false, #if mode editor is active
        "function": "submit" #function executed for submit
        })
    formulaire.from_data({
        "pseudo": "grognon",
        "age": 18,
        "un vecteur": Vector2(0, 3),
        "un autre vecteur": Vector3(0, 3, 5),
        "couleur": Color(0,1,1),
        "un truc": ["uiuiui", "popopop", "fufufu"],
        "un objet": {
            "name": "je sais pas quoi mettre",
            "date": "01/01/1000"
            }
        })

#     var item = class_truc.new(1)


func test_from_resource():
    var formulaire = Form.new()
    add_child(formulaire)
    var item = class_resource_exemple.new()
    formulaire.init({
        "name": "un joli formulaire",
        "node": self, #where generate the form
        "editor": false, #if mode editor is active
        "function": "submit" #function executed for submit
        })
    formulaire.from_resource(item)
