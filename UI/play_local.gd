extends Button



func _ready():
	pass 


func _on_play_local_button_down():
	get_tree().change_scene("Scenes/GrassLand.tscn")
	print("Playing local")
