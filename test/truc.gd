
class_name Truc

export(int) var id: int = 1 
export(String) var name: String = "grognon"
export(int, 0, 9999) var maxStackSize: int = 1
export(float) var nombre_reel: float = 0

func _init(id):
  self.id = id
