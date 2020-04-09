
class_name Truc

export(int) var id: int = 1 
export(String) var name: String = ""
export(int, 0, 9999) var maxStackSize: int = 1
export(String) var action: String = "none"

func _init(id):
  self.id = id
