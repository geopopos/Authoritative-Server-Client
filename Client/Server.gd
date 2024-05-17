extends Node

signal server_disconnected

const PORT = 7000
const DEFAULT_SERVER_IP = "127.0.0.1"

signal connected_to_game_server

var players = {}

var player_info = {"name": "Name"}

var player_character = preload("res://scenes/player_character.tscn")

var game_scene

func _ready():
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	

	
	
func connect_to_game(ip = "", port=7000, player_name = ""):
	if ip == "":
		ip = DEFAULT_SERVER_IP
	if port == 0:
		port = PORT
	if player_name == "":
		player_name = "No Name"
		
	player_info['name'] = player_name
	# create client
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(ip, port)
	if error:
		return error
	multiplayer.multiplayer_peer = peer
	
	print("client initialized")
	
	#game_scene = $/root/Game
	
func _on_connected_ok():
	print("connected to server!")
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = player_info
	print("Give peer id: " + str(peer_id))
	connected_to_game_server.emit()
	
func _on_connected_failed():
	multiplayer.multiplayer_peer = null
	print("failed to connect to server")
	
func _on_server_disconnected():
	multiplayer.multiplayer_peer = null
	players.clear()
	print("server disconnected")
	server_disconnected.emit()

@rpc("reliable")
func load_player(id, new_player_info):
	if id == multiplayer.get_unique_id():
		player_info = new_player_info
	var players_container = $/root/Game.get_node("Players")
	var new_character = player_character.instantiate()
	new_character.name = str(id)
	new_character.position = Vector2(new_player_info['pos']['x'], new_player_info['pos']['y'])
	players_container.add_child(new_character)
