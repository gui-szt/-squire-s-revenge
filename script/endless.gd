extends Node2D

var m=0
var score=0
var obs_animi
var obs_anim
var boss=1
var OBS
var stop =0
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fade_in")
	obs_animi=$enemys/mage
	anim()
	$Timer.timeout.connect(anim)
	$Timer.start()
	$score.timeout.connect(scor)
	$score.start()
	change_anim()
	$Timer2.timeout.connect(change_anim)
	$Timer2.start()
func scor():
	if stop==0:
		score+=1
		$score.start()

func _process(delta):
	$pontuacao.text= "score:"+str(score)
	if score>GlobalVars.score:
		GlobalVars.score=score
		GlobalVars.save_score()
func anim():
	$AnimationPlayer.play("boss_out")
	await $AnimationPlayer.animation_finished
	clean()
	print("1")
	boss=randi_range(1, 3)
	$Timer.start()
	match boss:
		1:
			obs_animi=$enemys/mage
			obs_animi.visible= true
			$cooldown.timeout.connect(rock_fire)
			$cooldown.start()
			
		2:
			obs_animi=$enemys/priest
			obs_animi.visible=true
			$cooldown.timeout.connect(cross)
			$cooldown.start()
		3:
			
			obs_animi=$enemys/knight
			obs_animi.visible=true
			$cooldown.timeout.connect(swords)
			$cooldown.start()
	$AnimationPlayer.play("boss_in")
func change_anim():
	print("2")
	var moment = randi_range(1, 3)
	var y =1
	if y==1:
		match moment:
			1:
				obs_animi.play("fire")
				y=0
			2:
				obs_animi.play("rocks")
				y=0
			3:
				obs_animi.play("default")
				y=0
				
		y=1

func clean():
	$enemys/mage.visible=false
	$enemys/priest.visible= false
	$enemys/knight.visible= false
	$cooldown.timeout.disconnect(swords)
	$cooldown.timeout.disconnect(rock_fire)
	$cooldown.timeout.disconnect(cross)
	var i=get_node("obs").get_child_count()
	if i !=0:
		while i>0:
			get_node("obs").get_child(i-1).queue_free()
			i-=1
	m=0

func cross():
	var time=3
	var time_offset: float = 0.2
	var posit=45
	var x
	var step=0
	if step ==0:
		m= randi_range(1,2)
		match m:
			1:
				OBS =preload("res://scenes/croos_fall.tscn")
				time=0.5
				var spawn_rate = time_offset / (1.0+ (GlobalVars.level * 0.1))
				$cooldown.wait_time =(spawn_rate + randf_range(0.2, 0.5))
			2:
				OBS=preload("res://scenes/cross_rotation.tscn")
				time=4
				$cooldown.wait_time=3
		var instance = OBS.instantiate()
		get_node("obs").add_child(instance)
		instance.visible= true
		obs_anim=instance.get_node("AnimatedSprite")
		if m==1 :
			time_offset=0.4
			x=randi_range(1,4)
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
		if m==2:
			step=1
			x=randi_range(1,4)
			time_offset= 0
			match x:
				1:
					posit= -45
				2:
					posit=45
				3:
					posit= -45
				4:
					posit=45
					
		instance.global_position.y = posit
		$cooldown.start()
		step=0
		return instance
func swords():
	if m<2:
		var SWORD=preload("res://scenes/sword.tscn")
		var instance = SWORD.instantiate()
		get_node("obs").add_child(instance)
		instance.visible= true
		m+=1
		$cooldown.start()
		return instance
func rock_fire():
	m= randi_range(1,2)
	if m==1:
		OBS= preload("res://scenes/rock.tscn")
	if m==2:
		OBS= preload("res://scenes/fire_ball.tscn")
	var posit
	var time_offset: float = 0.7
	var instance = OBS .instantiate()
	get_node("obs").add_child(instance)
	instance.visible= true
	obs_anim=instance.get_node("AnimatedSprite")
	var x= randi_range(1, 4)
	match x:
		1:
			obs_anim.flip_v= false
			posit=-55
		2:
			obs_anim.flip_v= false
			posit=33
		3:
			obs_anim.flip_v= true
			if m==1:
				posit= -22
			if m ==2:
				posit=-7
		4:
			obs_anim.flip_v= true
			if m==1:
				posit= 69
			if m==2:
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
	instance.global_position.y = posit
	var spawn_rate = time_offset / (1.0+ (9 * 0.1))
	$cooldown.wait_time=spawn_rate
	$cooldown.start()
	return instance


func _on_shielder_death():
	stop =1
