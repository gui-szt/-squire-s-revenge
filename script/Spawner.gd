extends Node2D

var posit = 0
var obs_anim 
var obs = 0
var moment = 1
@onready var timer_rock = $Timer_rock
const ROCK = preload("res://scenes/rock.tscn")

func _process(delta):
	if moment >1:
		get_parent().get_node("rock").get_child(moment).position.x+=delta*-200

func _ready():
	timer_rock.timeout.connect(spawn.bind(ROCK, timer_rock))
	
func spawn(scene: PackedScene,timer: Timer,time_offset: float = 1.0, parent: Node = get_parent().get_node("rock")) -> Node:
	obs=GlobalVars.obstacle
	var instance = scene.instantiate()
	parent.add_child(instance)
	match obs:
		1:
			instance.visible= true
			obs_anim=instance.get_node("rocks")
	moment +=1
	
	var x= randi_range(1, 4)
	match x:
		1:
			obs_anim.flip_v= false
			posit= -42
		2:
			obs_anim.flip_v= false
			posit = 26
		3:
			obs_anim.flip_v= true
			posit= -15
		4:
			obs_anim.flip_v= true
			posit= 53
	var rocks= randi_range(1, 4)
	match rocks:
		1:
			obs_anim.play("rock1")
		2:
			obs_anim.play("rock2")
		3:
			obs_anim.play("rock3")
		4:
			obs_anim.play("rock4")
		
	instance.global_position.y = posit
	var spawn_rate = time_offset / (0.5 + (GlobalVars.level * 0.1))
	timer.start(spawn_rate + randf_range(0.25, 0.5))
	timer_rock.wait_time = randi_range(1,3)
	timer.start()
	return instance


