extends CharacterBody2D

var change =0
var trails = 0

func upsidedown():
	$AnimatedSprite2D.flip_v = true
	if trails==0:
		position.y = -15
	
	else:
		position.y = 53
		
func back():
	$AnimatedSprite2D.flip_v= false
	if trails==0:
		position.y = -42
	else:
		position.y = 26
	
