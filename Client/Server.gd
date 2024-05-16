extends Node

signal server_disconnected

const PORT = 7000
const DEFAULT_SERVER_IP = "127.0.0.1"

signal connected_to_game_server

var players = {}

var player_info = {"name": "Name"}

var player_character = preload("res://scenes/player_character.tscn")

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
	
	#await get_tree().create_timer(2).timeout
	#$/root/Game/Players.add_child(player_character.instantiate())
	
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
