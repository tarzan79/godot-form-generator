tool
extends EditorPlugin


func _enter_tree():
    pass
#    add_custom_type("Form", "Control", preload("form.gd"), preload("icon.svg"))

func _exit_tree():
    # Clean-up of the plugin goes here
    # Always remember to remove it from the engine when deactivated
    pass
    remove_custom_type("Form")

func has_main_screen():
   return true

func get_plugin_name():
   return "Form generator"


#[ ]TYPE_NIL = 0 — Variable is null.
#[ ]TYPE_BOOL = 1 — Variable is of type bool.
#[x]TYPE_INT = 2 — Variable is of type int.
#[ ]TYPE_REAL = 3 — Variable is of type float (real).
#[x]TYPE_STRING = 4 — Variable is of type String.
#[ ]TYPE_VECTOR2 = 5 — Variable is of type Vector2.
#[ ]TYPE_RECT2 = 6 — Variable is of type Rect2.
#[ ]TYPE_VECTOR3 = 7 — Variable is of type Vector3.
#[ ]TYPE_TRANSFORM2D = 8 — Variable is of type Transform2D.
#[ ]TYPE_PLANE = 9 — Variable is of type Plane.
#[ ]TYPE_QUAT = 10 — Variable is of type Quat.
#[ ]TYPE_AABB = 11 — Variable is of type AABB.
#[ ]TYPE_BASIS = 12 — Variable is of type Basis.
#[ ]TYPE_TRANSFORM = 13 — Variable is of type Transform.
#[x]TYPE_COLOR = 14 — Variable is of type Color.
#[ ]TYPE_NODE_PATH = 15 — Variable is of type NodePath.
#[ ]TYPE_RID = 16 — Variable is of type RID.
#[ ]TYPE_OBJECT = 17 — Variable is of type Object.
#[x]TYPE_DICTIONARY = 18 — Variable is of type Dictionary.
#[x]TYPE_ARRAY = 19 — Variable is of type Array.
#[ ]TYPE_RAW_ARRAY = 20 — Variable is of type PoolByteArray.
#[ ]TYPE_INT_ARRAY = 21 — Variable is of type PoolIntArray.
#[ ]TYPE_REAL_ARRAY = 22 — Variable is of type PoolRealArray.
#[ ]TYPE_STRING_ARRAY = 23 — Variable is of type PoolStringArray.
#[ ]TYPE_VECTOR2_ARRAY = 24 — Variable is of type PoolVector2Array.
#[ ]TYPE_VECTOR3_ARRAY = 25 — Variable is of type PoolVector3Array.
#[ ]TYPE_COLOR_ARRAY = 26 — Variable is of type PoolColorArray.
#[ ]TYPE_MAX = 27 — Represents the size of the Variant.Type enum.
