extends Node2D
	
func _on_PlayOnline_pressed():		#when button is pressed load lobby then swith scenes to lobby
	var Lobby = preload("res://Levels/Lobby.tscn").instance()
	get_tree().get_root().add_child(Lobby)
	hide()
	
func _on_PlayLocal_pressed():		#when button is pressed load main game then swith scenes to main game
	var game = preload("res://Scenes/Demo.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()
