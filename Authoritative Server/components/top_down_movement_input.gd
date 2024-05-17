extends Node

@export var actor: CharacterBody2D
@export var top_down_movement_stats: TopDownMovementStats

var input: Vector2

func _physics_process(delta):
	actor.velocity = input * top_down_movement_stats.max_speed
	actor.move_and_slide()

@rpc("any_peer", "unreliable")
func get_input(input_vector: Vector2):
	input = input_vector
