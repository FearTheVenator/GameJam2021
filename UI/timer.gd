extends RichTextLabel

var s = 0
var m = 3

func _process(delta):
	
	if s < 1:
		m -= 1
		s = 59
		
	if (m < 1 && s < 1):
		print("times up")
		
		
	set_text(str(m)+":"+str(s))
	
	pass

func _on_ms_timeout():
	s -= 1
	pass
