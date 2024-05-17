extends CharacterBody2D



func _physics_process(delta):
	print("process running")
	velocity = Vector2(20,20)
	move_and_slide()

