extends Node2D


var player_spawn: Marker2D

var player_character = preload("res://scenes/player_character.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	player_spawn = $InitialPlayerSpawn


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_new_player(id):
	var player_spawn_pos = player_spawn.global_position
	
	Server.players[id] = {
		"pos":
				{
					"x": player_spawn_pos.x,
					"y": player_spawn_pos.y
				}
		}
		
	var new_character = player_character.instantiate()
	new_character.name = str(id)
	new_character.position = player_spawn_pos
	$Players.add_child(new_character)
