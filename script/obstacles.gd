extends Node2D

var rocks = 0
var posit = 0

@onready var obstacles = $"."


func _rocks():
	$rock.visible= true
	await get_tree().create_timer(randi_range(1,4)).timeout
	rocks= randi_range(1, 4)
	posit = randi_range(1, 4)
	
	match rocks:
		1:
			$rock/rocks.play("rock1")
		2:
			$rock/rocks.play("rock2")
		3:
			$rock/rocks.play("rock3")
		4:
			$rock/rocks.play("rock4")
	match posit:
		1:
			$rock/rocks.flip_v= false
			position.y = -42
		2:
			$rock/rocks.flip_v= false
			position.y = 26
		3:
			$rock/rocks.flip_v= true
			position.y = -15
		4:
			$rock/rocks.flip_v= true
			position.y = 53
	

