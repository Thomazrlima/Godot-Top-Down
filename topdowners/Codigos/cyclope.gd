extends CharacterBody2D
class_name Cyclope

var _player_ref = null
var _is_dead: bool = false
var health: int = 4
var attack_damage: int = 1
var can_attack: bool = true 

@export_category("Objects")
@export var _texture: Sprite2D = null
@export var _animation: AnimationPlayer = null
@export var attack_cooldown: float = 1.2
@export var _cooldown_timer: Timer = null

@onready var effects = $Effects
@onready var hurtTimer = $hurtTimer
@onready var life_bar: ProgressBar = $ProgressBar
@onready var hurt: AudioStreamPlayer2D = $hurt

func _ready() -> void:
	effects.play("RESET")
	life_bar.max_value = 4
	life_bar.value = health
	
	if _cooldown_timer == null:
		_cooldown_timer = Timer.new()
		_cooldown_timer.wait_time = attack_cooldown
		_cooldown_timer.one_shot = true
		add_child(_cooldown_timer)
		_cooldown_timer.connect("timeout", Callable(self, "_on_cooldown_finished"))

func _on_detection_body_entered(_body: Node2D) -> void:
	if _body.is_in_group("character"):
		_player_ref = _body

func _on_detection_body_exited(_body: Node2D) -> void:
	if _body.is_in_group("character"):
		_player_ref = null

func _physics_process(delta: float) -> void:
	if _is_dead:
		return
	
	_animate()
	if _player_ref != null:
		if _player_ref.is_dead:
			velocity = Vector2.ZERO
			move_and_slide()
			return
		
		var _direction: Vector2 = global_position.direction_to(_player_ref.global_position)
		var _distance: float = global_position.distance_to(_player_ref.global_position)
		
		if _distance < 20 and can_attack:
			attack_player()
		
		velocity = _direction * 40
		move_and_slide()

func attack_player() -> void:
	if _player_ref != null and not _player_ref.is_dead:
		_player_ref.take_damage(attack_damage, global_position)
		can_attack = false 
		_cooldown_timer.start()

func _on_cooldown_finished() -> void:
	can_attack = true

func _animate() -> void:
	if velocity.x > 0:
		_texture.flip_h = true
	
	if velocity.x < 0:
		_texture.flip_h = false
	
	if velocity != Vector2.ZERO:
		_animation.play("walk")
		return
	_animation.play("idle")

func take_damage(amount: int) -> void:
	health -= amount
	life_bar.value = health  
	hurt.play()
	
	if health <= 0:
		die()
	
	effects.play("hurt")
	hurtTimer.start()
	await hurtTimer.timeout
	effects.play("RESET")

func die() -> void:
	_is_dead = true
	await get_tree().create_timer(0.2).timeout
	queue_free()
