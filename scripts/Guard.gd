extends KinematicBody2D

func _ready():
	print("Guard[", get_instance_id(), "]: ready")

func _physics_process(delta):
	pass

func _on_BodyArea_area_entered(area):
	print("Guard[", get_instance_id(), "]: hitted")
