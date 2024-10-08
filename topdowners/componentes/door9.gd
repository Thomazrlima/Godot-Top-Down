extends Area2D
class_name Door9

var player_ref: Character = null

@export_category("Variables")
@export var teleport_position: Vector2 = Vector2(-750, -368)

func _on_body_entered(body: Node2D) -> void:
	if body is Character:
		player_ref = body
		teleport_player()

func teleport_player() -> void:
	if player_ref != null:
		player_ref.global_position = teleport_position
