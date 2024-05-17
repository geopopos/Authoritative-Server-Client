extends Node2D

func _ready():
	Server.server_connection_failed.connect(_on_server_connection_failed)


func _on_server_connection_failed():
	print("server connection failed")
	$CanvasLayer/CenterContainer/VBoxContainer/ErrorLabel.text = "Failed to connect to server. Please Try Again Later"

func _on_connect_to_game_pressed():
	var ip_address = $CanvasLayer/CenterContainer/VBoxContainer/IPAddress.text
	var port = int($CanvasLayer/CenterContainer/VBoxContainer/Port.text)
	var your_name = $CanvasLayer/CenterContainer/VBoxContainer/YourName.text
	
	var error = Server.connect_to_game(ip_address, port, your_name)
	if error:
		$CanvasLayer/CenterContainer/VBoxContainer2/ErrorLabel.text = "Error: Could Not Connect To Server. Please Try Again."
