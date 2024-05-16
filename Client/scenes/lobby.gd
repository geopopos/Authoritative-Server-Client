extends Node2D

func _on_connect_to_game_pressed():
	var ip_address = $CanvasLayer/CenterContainer/VBoxContainer/IPAddress.text
	var port = int($CanvasLayer/CenterContainer/VBoxContainer/Port.text)
	var your_name = $CanvasLayer/CenterContainer/VBoxContainer/YourName.text
	
	var error = Server.connect_to_game(ip_address, port, your_name)
	if error == ERR_CANT_CREATE:
		$CanvasLayer/CenterContainer/VBoxContainer2/ErrorLabel.text = "Error: Could Not Connect To Server. Please Try Again."
