extends Node2D

@onready var lifeContainer = $CanvasLayer/Life
@onready var player = $YSort/Character
@onready var accept: AudioStreamPlayer2D = $Accept

func _ready() -> void:
	accept.play()
	lifeContainer.setMaxHearts(player.maxHealth)
	lifeContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(lifeContainer.updateHearts)

func _process(delta: float) -> void:
	pass
