extends Button



func _ready():
	pass 
	

func _on_play_online_button_down():
	get_tree().change_scene("res://Levels/Lobby.tscn")
	print("Playing online")
