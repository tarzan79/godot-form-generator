extends HBoxContainer


func _ready():
    pass


func _on_Button_pressed():
    $FileDialog.show()


func _on_FileDialog_file_selected(path):
    $LineEdit.text = path
