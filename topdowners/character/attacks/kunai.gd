extends Area2D

var _direction: Vector2 = Vector2.ZERO
var damage: int = 1

func _ready() -> void:
	randomize()
	_direction = global_position.direction_to(get_global_mouse_position())
	var angle = _direction.angle()
	rotation_degrees = rad_to_deg(angle)

	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))

func _physics_process(delta: float) -> void:
	translate(_direction * delta * 200)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		body.take_damage(damage)
		queue_free()
