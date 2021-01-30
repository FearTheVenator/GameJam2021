extends Control

var counter = 0

func _ready():
	$Timer.text = str(counter)

func _on_Timer_timeout():
	counter += 1
	$Timer.text = str(counter)
