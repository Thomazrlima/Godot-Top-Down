extends Control
class_name MenuPrincipal

var _has_saved: bool = false

func _ready() -> void:
	if _has_saved == false:
		pass
	
	for _buttom in get_tree().get_nodes_in_group("button"):
		_buttom.pressed.connect(_on_button_pressed.bind(_buttom))
		
func _on_button_pressed(_button: Button) -> void:
	match _button.name:
		"Novo Jogo":
			get_tree().change_scene_to_file("res://levels/level.tscn")
		
		"Continuar":
			get_tree().change_scene_to_file("res://levels/level.tscn")
		
		"Sair":
			get_tree().quit()
