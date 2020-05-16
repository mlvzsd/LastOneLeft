extends KinematicBody2D

const SPEED = 70

var velocity := Vector2()

func _ready():
	print("Player: ready")

func _physics_process(delta):
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	
	velocity.x = int(right) - int(left)
	velocity.y = int(down) - int(up)
	
	move_and_collide(velocity * SPEED * delta)
