extends KinematicBody2D

const SPEED = 70

var velocity := Vector2()
var anim_status := "idle"
var anim_direction := "down"
var is_armed := true
var hitting := false

func current_hitter():
	if anim_direction == "right" and $AnimatedSprite.flip_h:
		return "LeftHitter/CollisionShape2D"
	
	return str(anim_direction.capitalize(), "Hitter/CollisionShape2D")

func _ready():
	print("Player: ready")

func _physics_process(delta):
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	var hit = Input.is_action_just_pressed("ui_hit")
	
	velocity.x = int(right) - int(left)
	velocity.y = int(down) - int(up)
	velocity = velocity.normalized()
	
	if hitting:
		return
	
	if hit and is_armed:
		var anim_name = str("hit_", anim_direction)
		
		$AnimatedSprite.play(anim_name)
		get_node(current_hitter()).disabled = false
		hitting = true
		
		return
	
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
	if area.get("damage") and not is_a_parent_of(area):
		print("Player: hitted")

func _on_AnimatedSprite_animation_finished():
	if hitting:
		get_node(current_hitter()).disabled = true
		hitting = false
