extends Area2D
class_name Door5

var player_ref: Character = null

@export_category("Variables")
@export var teleport_position: Vector2 = Vector2(-1186, -266)

func _on_body_entered(body: Node2D) -> void:
	if body is Character:
		player_ref = body
		teleport_player()

func teleport_player() -> void:
	if player_ref != null:
		player_ref.global_position = teleport_position
