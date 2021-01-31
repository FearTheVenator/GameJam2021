extends Node2D
var IPAddress
func _ready():
	get_tree().connect("network_peer_connected",self,"_player_connected")

func _on_BackButton_pressed():		#when button is pressed load main menu then swith scenes to main menu
	var MainM = preload("res://UI/main_menu.tscn").instance()
	get_tree().get_root().add_child(MainM)
	hide()
	

func _on_ButtonHost_pressed():
	var net = NetworkedMultiplayerENet.new()
	net.create_server(6969,2)
	get_tree().set_network_peer(net)
	print("hosting")

func _on_ButtonJoin_pressed():
	
	var net = NetworkedMultiplayerENet.new()
	net.create_client(str(IPAddress),6969)
	get_tree().set_network_peer(net)
	
func _player_connected(id):
	Globals.player2id = id
	var game = preload("res://Scenes/HauntedHouse.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()
	

func _on_LineEdit_text_changed(new_text):
	IPAddress = new_text
	print(str(IPAddress))
