extends CharacterBody2D

var _state_machine

@export_category("Variables")
@export var SPEED: float = 70.0
@export var ACCELERATION: float = 0.2
@export var BREAK: float = 0.2

@export_category("Objects")
@export var _animation_tree: AnimationTree = null

func _ready() -> void:
	if _animation_tree:
		_state_machine = _animation_tree.get("parameters/playback")

func _physics_process(_delta: float) -> void:
	_move()
	_animate()
	move_and_slide()

func _move() -> void:
	var _direcao: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	if _direcao != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direcao
		_animation_tree["parameters/walk/blend_position"] = _direcao
		
		velocity.x = lerp(velocity.x, _direcao.normalized().x * SPEED, ACCELERATION)
		velocity.y = lerp(velocity.y, _direcao.normalized().y * SPEED, ACCELERATION)
	else:
		velocity.x = lerp(velocity.x, _direcao.normalized().x * SPEED, BREAK)
		velocity.y = lerp(velocity.y, _direcao.normalized().y * SPEED, BREAK)

func _animate() -> void:
	if velocity.length() > 5:
		_state_machine.travel("walk")
	else:
		_state_machine.travel("idle")
