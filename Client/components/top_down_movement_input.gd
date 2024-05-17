extends Node

class_name TopDownMovementInput

@export var actor: CharacterBody2D


func _ready():
	set_process(actor.name == str(multiplayer.get_unique_id()))

func _process(delta):
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	get_input.rpc_id(1, input)


@rpc("unreliable", "any_peer")
func get_input(input_vector: Vector2):
	pass
