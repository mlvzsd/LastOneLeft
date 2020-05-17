extends KinematicBody2D

const SPEED = 50

var velocity := Vector2()
var anim_status := "idle"
var anim_direction := "down"
var target : KinematicBody2D

func _ready():
	print("Guard[", get_instance_id(), "]: ready")

func _physics_process(delta):
	velocity = (target.position - position).normalized()
	
	move_and_collide(velocity * SPEED * delta)
	
	if velocity == Vector2.ZERO:
		anim_status = "idle"
	else:
		anim_status = "walk"
		
		if abs(velocity.x) > abs(velocity.y):
			anim_direction = "right"
			$AnimatedSprite.flip_h = velocity.x < 0
		else:
			anim_direction = "up" if velocity.y < 0 else "down"
	
	var anim_name = str(anim_status, "_", anim_direction)
	
	$AnimatedSprite.play(anim_name)

func _on_BodyArea_area_entered(area):
	print("Guard[", get_instance_id(), "]: hitted")
