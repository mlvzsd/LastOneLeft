extends KinematicBody2D

const SPEED = 70

var velocity := Vector2()
var anim_status := "idle"
var anim_direction := "down"
var is_armed := false

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
	
	z_index = position.y
	
	if velocity == Vector2.ZERO:
		anim_status = "idle"
	else:
		anim_status = "walk"
		
		match velocity:
			Vector2.LEFT:
				anim_direction = "right"
				$AnimatedSprite.flip_h = true
			Vector2.RIGHT:
				anim_direction = "right"
				$AnimatedSprite.flip_h = false
			Vector2.UP:
				anim_direction = "up"
			Vector2.DOWN:
				anim_direction = "down"
	
	var anim_name = str(anim_status, "_", anim_direction,
		"_armed" if is_armed else "")
	
	$AnimatedSprite.play(anim_name)

func _on_BodyArea_area_entered(area):
	print("Player: hitted")

func _on_AnimatedSprite_animation_finished():
	pass
