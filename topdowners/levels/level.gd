extends Node2D

@onready var lifeContainer = $CanvasLayer/Life
@onready var player = $YSort/Character

func _ready() -> void:
	lifeContainer.setMaxHearts(player.maxHealth)
	lifeContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(lifeContainer.updateHearts)

func _process(delta: float) -> void:
	pass
