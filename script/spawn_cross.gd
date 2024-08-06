extends Node2D
var progress =GlobalVars.progress
var level = GlobalVars.level
var posit 
var obs_anim 
var obs 
var moment
var x
var time=0
@onready var timer_rock = $Timer_rock
var OBS = preload("res://scenes/croos_fall.tscn")
const CROSS_F=preload("res://scenes/croos_fall.tscn")
const CROSS_R=preload("res://scenes/cross_rotation.tscn")

func randomi():
	x= randi_range(1, 4)
	match x:
		1:
			obs_anim.flip_v= false
		2:
			obs_anim.flip_v= false
<<<<<<< HEAD:script/spawn_cross.gd
=======
			if obs== 4 or obs==5 or obs==6:
				obs_anim.flip_h= false
			else:
				if GlobalVars.level==3:
					posit=-55
				else:
					posit = 35
>>>>>>> main:script/Spawner.gd
		3:
			obs_anim.flip_v= true
		4:
			obs_anim.flip_v= true
<<<<<<< HEAD:script/spawn_cross.gd

=======
			if obs== 4 or obs==5 or obs==6:
				obs_anim.flip_h=true
			if obs==1:
				if GlobalVars.level==3:
					posit= -24
				else:
					posit= 66
			if obs==2:
				if GlobalVars.level==3:
					posit= -7
				else:
					posit=83
			
>>>>>>> main:script/Spawner.gd
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

func _ready():
	match level:
		4:
			obs=4
			OBS = CROSS_F
			timer_rock.start()
			timer_rock.timeout.connect(spawn.bind(OBS, timer_rock ))
			
		5:
			obs=5
			OBS = CROSS_R
			timer_rock.start()
			timer_rock.timeout.connect(spawn.bind(OBS, timer_rock ))
			
		6:
			obs=6
			moment= randi_range(1, 2)
			match moment:
				1:
					OBS =CROSS_F
					obs=4
					timer_rock.start()
					timer_rock.timeout.connect(spawn.bind(OBS, timer_rock ))
				2:
					obs=5
					OBS=CROSS_R
					timer_rock.start()
					timer_rock.timeout.connect(spawn.bind(OBS, timer_rock ))

func _process(delta):
	if obs==6 or progress>9:
		await get_tree().create_timer(time).timeout
		match moment:
			1:
				timer_rock.timeout.disconnect(spawn.bind(OBS, timer_rock ))
				OBS =CROSS_F
				obs=4
				timer_rock.timeout.connect(spawn.bind(OBS, timer_rock ))
			2:
				timer_rock.timeout.disconnect(spawn.bind(OBS, timer_rock ))
				OBS=CROSS_R
				obs=5
				timer_rock.timeout.connect(spawn.bind(OBS, timer_rock ))
				
	if obs==6 and moment ==1:
		time=4

func spawn(scene: PackedScene,timer: Timer, parent: Node =get_parent().get_node("obs")) -> Node:
	var time_offset: float = 0.2
	var instance = scene.instantiate()
	parent.add_child(instance)
	instance.visible= true
	obs_anim=instance.get_node("AnimatedSprite")
	randomi()
	if obs==4 :
		time_offset=0.4
		match x:
			1:
				instance.cross=0
				posit=200
				obs_anim.rotation=2.44346
			2:
				instance.cross=0
				posit=200
				obs_anim.rotation=2.44346
			3:
				instance.cross=1
				posit=-200
				obs_anim.rotation=-2.44346
			4:
				instance.cross=1
				posit=-200
				obs_anim.rotation=-2.44346
	if obs==6:
		time_offset=0.6
	if obs==5:
		time_offset= 0.1
		match x:
			1:
				posit= -45
			2:
				posit=45
			3:
				posit= -45
			4:
				posit=45
	moment= randi_range(1, 2)
	instance.global_position.y = posit
	var spawn_rate = time_offset / (1.0+ (GlobalVars.level * 0.1))
	timer_rock.wait_time =(spawn_rate + randf_range(0.2, 0.5))
	if obs==5:
		timer_rock.wait_time=3.0
	if level==4 or level==5 or level==6:
		obs=GlobalVars.level
	if progress>=9:
		obs=6
	timer_rock.start()
	return instance
