extends CharacterBody2D

var input: Vector2
@export var speed: float = 200

func _physics_process(delta):
	print("process running")
	velocity = input * speed
	move_and_slide()

@rpc("any_peer", "unreliable")
func get_input(input_vector: Vector2):
	input = input_vector
