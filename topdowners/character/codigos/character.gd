extends CharacterBody2D
class_name Character

const KUNAI: PackedScene = preload("res://character/attacks/kunai.tscn")

var is_dead: bool = false
var _state_machine
var attacking: bool = false

@export_category("Variables")
@export var SPEED: float = 90.0
@export var ACCELERATION: float = 0.2
@export var BREAK: float = 0.2

@export_category("Objects")
@export var _timer: Timer = null
@export var _animation_tree: AnimationTree = null
@export var _shadow: Sprite2D = null 

func _ready() -> void:
	if _animation_tree:
		_state_machine = _animation_tree.get("parameters/playback")
	if _shadow:
		_shadow.position = Vector2(0, 10)

func _physics_process(_delta: float) -> void:
	if is_dead:
		return
		
	_move()
	_attack()
	_animate()
	move_and_slide()
	_update_shadow_position()

func _update_shadow_position() -> void:
	if _shadow:
		_shadow.position = Vector2(0, 10)

func _move() -> void:
	var _direcao: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)

	if _direcao != Vector2.ZERO:
		_update_animation_blend_position(_direcao)

		velocity.x = lerp(velocity.x, _direcao.normalized().x * SPEED, ACCELERATION)
		velocity.y = lerp(velocity.y, _direcao.normalized().y * SPEED, ACCELERATION)
	else:
		velocity.x = lerp(velocity.x, _direcao.normalized().x * SPEED, BREAK)
		velocity.y = lerp(velocity.y, _direcao.normalized().y * SPEED, BREAK)

func _attack() -> void:
	if Input.is_action_just_pressed("attack") and not attacking:
		_timer.start()
		attacking = true
		spawn_kunai() 

func _update_animation_blend_position(blend_position: Vector2) -> void:
	_animation_tree["parameters/idle/blend_position"] = blend_position
	_animation_tree["parameters/walk/blend_position"] = blend_position
	_animation_tree["parameters/attack/blend_position"] = blend_position

func spawn_kunai() -> void:
	var kunai = KUNAI.instantiate()
	kunai.global_position = global_position + Vector2(0, 0.5)
	get_tree().root.call_deferred("add_child", kunai)
	print("Kunai lançada")

func _animate() -> void:
	var direction = get_direction()
	var move_direction = velocity.normalized()

	if abs(move_direction.y) > abs(move_direction.x):
		if move_direction.y < 0:
			_update_animation_blend_position(Vector2(0, -1))
		else:
			_update_animation_blend_position(Vector2(0, 1))
	else:
		if direction.x < 0:
			_update_animation_blend_position(Vector2(-1, 0))
		else:
			_update_animation_blend_position(Vector2(1, 0))

	if attacking:
		_state_machine.travel("attack")
		return

	if velocity.length() > 5:
		_state_machine.travel("walk")
	else:
		_state_machine.travel("idle")

func get_direction() -> Vector2:
	return global_position.direction_to(get_global_mouse_position())

func _on_attack_timer_timeout() -> void:
	attacking = false

func _on_areaattack_body_entered(_body) -> void:
	if _body.is_in_group("enemy"):
		_body.update_health()

func die() -> void:
	is_dead = true
	_state_machine.travel("death")
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
