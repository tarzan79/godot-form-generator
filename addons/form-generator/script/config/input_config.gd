extends PanelContainer

onready var label = $VBoxContainer/Label

var pressed = false
var decalage = 0

func _on_Label_gui_input(event):
    if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
        if event.pressed:
            pressed = true
            decalage = rect_position - get_viewport().get_mouse_position()
        if not event.pressed:
            pressed = false
    if event is InputEventMouseMotion && pressed == true:
        rect_position = get_viewport().get_mouse_position() + decalage
    
