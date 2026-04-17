extends CharacterBody2D

# Movement variables
var speed = 200
var velocity = Vector2.ZERO
var is_moving = false

# Signals
signal player_moved(position)
signal interaction_triggered(target)

func _ready():
	pass

func _physics_process(delta):
	handle_input()
	move_and_collide(velocity * delta)
	emit_signal("player_moved", global_position)

func handle_input():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		is_moving = true
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		is_moving = true
	if Input.is_action_pressed("ui_down"):
		velocity.y += speed
		is_moving = true
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
		is_moving = true
	
	if velocity == Vector2.ZERO:
		is_moving = false

func interact():
	emit_signal("interaction_triggered", global_position)

func get_position() -> Vector2:
	return global_position