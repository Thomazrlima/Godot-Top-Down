extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var animation_dialog = $AnimationDialog
@onready var _hud: CanvasLayer = $CanvasLayer

const _DIALOG_SCREEN: PackedScene = preload("res://dialog/dioaog_sreen.tscn")

var _dialog_data: Dictionary = {
	0: {
		"faceset": "res://character/Boy/Faceset.png",
		"dialog": "Moço, é melhor você não ir para lá",
		"title": "garoto"
	},
	1: {
		"faceset": "res://character/ninja/NinjaGreen/Faceset.png",
		"dialog": "Ué? Mas por quê?",
		"title": "ninja"
	},
	2: {
		"faceset": "res://character/Boy/Faceset.png",
		"dialog": "O pessoal está dizendo que monstros estão aparecendo lá",
		"title": "garoto"
	},
	3: {
		"faceset": "res://character/ninja/NinjaGreen/Faceset.png",
		"dialog": "A vila abandonada é moleza para mim",
		"title": "ninja"
	},
}

var _in_area: bool = false
var _dialog_active: bool = false 

func _process(_delta: float) -> void:
	if _in_area and Input.is_action_just_pressed("ui_accept") and not _dialog_active:
		var _new_dialog: DialogScreen = _DIALOG_SCREEN.instantiate()
		_new_dialog.data = _dialog_data
		_new_dialog.connect("tree_exited", Callable(self, "_on_dialog_exited")) 
		_hud.add_child(_new_dialog)
		_dialog_active = true

func _physics_process(delta: float) -> void:
	if not _dialog_active:
		animation_player.play("idle")
		animation_dialog.play("Dialog")
	else:
		animation_player.stop() 

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		_in_area = true 

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == self:
		_in_area = false

func _on_dialog_exited() -> void:
	_dialog_active = false 
