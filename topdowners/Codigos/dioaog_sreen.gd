extends Control
class_name DialogScreen

var _step: float = 0.05
var _id: int = 0
var data: Dictionary = {}
var is_active: bool = true

@export_category("Objects")
@export var _name: Label = null
@export var _dialog: RichTextLabel = null
@export var _faceset: TextureRect = null

func _ready() -> void:
	_initialize_dialog()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if _dialog.visible_characters >= _dialog.text.length():
			_id += 1
			if _id >= data.size():
				is_active = false
				queue_free()
				return
			
			_initialize_dialog()
		else:
			_dialog.visible_characters = _dialog.text.length()

func _initialize_dialog() -> void:
	if not data.has(_id):
		is_active = false
		queue_free()
		return
	
	_name.text = data[_id]["title"]
	_dialog.text = data[_id]["dialog"]
	_faceset.texture = load(data[_id]["faceset"])
	_dialog.visible_characters = 0
	_show_text_gradually()

func _show_text_gradually() -> void:
	var timer = Timer.new()
	timer.one_shot = false
	timer.wait_time = _step
	timer.connect("timeout", Callable(self, "_on_timeout"))
	add_child(timer)
	timer.start()

func _on_timeout() -> void:
	if _dialog.visible_characters < _dialog.text.length():
		_dialog.visible_characters += 1
	else:
		for child in get_children():
			if child is Timer:
				child.queue_free()
