extends CharacterBody2D


const SPEED = 400.0

func _physics_process(delta: ):
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += SPEED
	if Input.is_action_pressed("left"):
		velocity.x -= SPEED
	if Input.is_action_pressed("up"):
		velocity.y -= SPEED
	if Input.is_action_pressed("down"):
		velocity.y += SPEED
	move_and_slide()
	look_at(get_global_mouse_position())
