extends Node2D



func _on_start_pressed():
	var port = int($CanvasLayer/CenterContainer/VBoxContainer/Port.text)
	var max_connections = int($CanvasLayer/CenterContainer/VBoxContainer/MaxPlayers.text)
	
	Server.start_server(port, max_connections)
