extends Node


signal player_connected(peer_id, player_info)
signal player_disconnected(id)

const PORT = 7000
const MAX_CONNECTIONS = 20

var players = {}


var players_loaded = 0


func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)

	
	
func _on_player_connected(id):
	print("new player connected")
	players[id] = "player " + str(id)
	
	
func _on_player_disconnected(id):
	players.erase(id)
	player_disconnected.emit(id)
	print("player disconnected: player " + str(id))
	
func start_server(port=5000, max_players=10):
	if port == 0:
		port = PORT
	if max_players == 0:
		max_players = MAX_CONNECTIONS
	print("PORT, " + str(port))
	print("max players, " + str(max_players))
	# initialize server
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, MAX_CONNECTIONS)
	if error:
		return error
	multiplayer.multiplayer_peer = peer
	print("server initialized")
