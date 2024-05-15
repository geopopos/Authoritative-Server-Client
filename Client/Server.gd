extends Node

signal server_disconnected

const PORT = 7000
const DEFAULT_SERVER_IP = "127.0.0.1"


var players = {}

var player_info = {"name": "Name"}


func _ready():
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	
	# create client
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(DEFAULT_SERVER_IP, PORT)
	if error:
		return error
	multiplayer.multiplayer_peer = peer
	
	print("client initialized")
	
	
func _on_connected_ok():
	print("connected to server!")
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = player_info
	print("Give peer id: " + str(peer_id))
	
func _on_connected_failed():
	multiplayer.multiplayer_peer = null
	print("failed to connect to server")
	
func _on_server_disconnected():
	multiplayer.multiplayer_peer = null
	players.clear()
	print("server disconnected")
	server_disconnected.emit()
