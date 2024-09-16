extends Control
class_name Ajuda

var _has_saved: bool = false
@onready var accept: AudioStreamPlayer2D = $Accept

func _ready() -> void:
	accept.play()
	
	if _has_saved == false:
		pass
	
	for _buttom in get_tree().get_nodes_in_group("button"):
		_buttom.pressed.connect(_on_button_pressed.bind(_buttom))
		
func _on_button_pressed(_button: Button) -> void:
	match _button.name:
		
		"Sair":
			get_tree().change_scene_to_file("res://menu/menu_principal.tscn")
