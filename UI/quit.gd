extends Button



func _ready():
	pass 


func _on_quit_button_down():
	get_tree().quit()
	print("Quitting")
