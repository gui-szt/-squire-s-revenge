extends Node2D
var level= GlobalVars.level
var progress= GlobalVars.progress
var posit 
var obs_anim 
var obs
var moment
var z=0

signal change_1
signal change_2

var x
var OBS= preload("res://scenes/rock.tscn")
const ROCK= preload("res://scenes/rock.tscn")
const FIRE = preload("res://scenes/fire_ball.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	if level==1:
		$Timer.start()
		obs=1
		$Timer.timeout.connect(spawn.bind(OBS))
	if level==2:
		$Timer.start()
		obs=2
		OBS=FIRE
		$Timer.timeout.connect(spawn.bind(OBS))
		
	if level==3:
		$Timer.start()
		OBS=ROCK
		obs=1
		$Timer.timeout.connect(spawn.bind(OBS))
		$Timer2.start()
func _process(delta):
	if z==1 and (level==3 or progress>=9):
		moment=randi_range(1,2)
		match moment:
			1:
				$Timer.timeout.disconnect(spawn.bind(OBS))
				OBS = ROCK
				obs=1
				$Timer.timeout.connect(spawn.bind(OBS))
				emit_signal("change_1")
				if level==3:
					$Timer2.start()
					z=0
			2:
				$Timer.timeout.disconnect(spawn.bind(OBS))
				OBS=FIRE
				obs=2
				$Timer.timeout.connect(spawn.bind(OBS))
				emit_signal("change_2")
				if level== 3:
					$Timer2.start()
					z=0


func spawn(scene: PackedScene):
	var time_offset: float = 0.2
	if level==3:
		time_offset= 0.5
	var instance = scene.instantiate()
	get_parent().get_node("obs").add_child(instance)
	instance.visible= true
	obs_anim=instance.get_node("AnimatedSprite")
	positio()
	instance.global_position.y = posit
	var spawn_rate = time_offset / (1.0+ (level * 0.1))
	$Timer.wait_time =(spawn_rate + randf_range(0.2, 0.5))
	$Timer.start()
	return instance

func _on_timer_2_timeout():
	z=1

func positio():

	if level==3:
		x= randi_range(3, 4)
		match x:
			3:
				obs_anim.flip_v= false
				if obs==1:
					posit= 17
				if obs ==2:
					posit=18
				
			4:
				obs_anim.flip_v= true
				if obs== 4 or obs==5 or obs==6:
					obs_anim.flip_h=true
				if obs==1:
					posit=52
				if obs==2:
					posit=65
	else:
		x= randi_range(1, 4)
		match x:
			1:
				obs_anim.flip_v= false
				posit=-55
			2:
				obs_anim.flip_v= false
				posit=33
			3:
				obs_anim.flip_v= true
				if obs==1:
					posit= -22
				if obs ==2:
					posit=-7
			4:
				obs_anim.flip_v= true
				if obs==1:
					posit= 69
				if obs==2:
					posit=83
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
