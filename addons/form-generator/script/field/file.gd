extends HBoxContainer

onready var value = $LineEdit.text
onready var label = $Label.text
onready var filedialog = $FileDialog

func _ready():
    pass

func init(data):
    print("data file")
    print(data)
    if data.has("label"):
        $Label.text = data.label
    if data.has("hint"):
        if data.hint == PROPERTY_HINT_DIR:
            $FileDialog.mode = FileDialog.MODE_OPEN_DIR
        if data.hint == PROPERTY_HINT_FILE:
            $FileDialog.mode = FileDialog.MODE_OPEN_FILE
            if data.hint_string != "":
                pass
                $FileDialog.set_filters(PoolStringArray(data.hint_string.split(","))) # set_filters(PoolStringArray(["*.png ; PNG Images","*.gd ; GDScript Files"]))
                    

func _on_Button_pressed():
    $FileDialog.show()


func _on_FileDialog_file_selected(path):
    $LineEdit.text = path

