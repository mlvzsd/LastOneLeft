extends KinematicBody2D

const SPEED = 50

var velocity := Vector2()
var target : KinematicBody2D

func _ready():
	print("Guard[", get_instance_id(), "]: ready")

func _physics_process(delta):
	velocity = (target.position - position).normalized()
	
	move_and_collide(velocity * SPEED * delta)

func _on_BodyArea_area_entered(area):
	print("Guard[", get_instance_id(), "]: hitted")
