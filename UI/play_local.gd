extends Button



func _ready():
	pass 


func _on_play_local_button_down():
	get_tree().change_scene("Scenes/Demo.tscn")
	print("Playing local")
