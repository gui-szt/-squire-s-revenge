extends Node2D

var cooldown =0
var obstacle = 0

@onready var obstacles= $run/obstacles_scene
@onready var timer = $run/Timer
@onready var shielder = $run/shielder

func _on_timer_timeout():
	cooldown=1

func _process(delta):
	
	##RANDOM OBSTACLES IN BOSS-LEVELS
	if GlobalVars.level==3 or GlobalVars.level==6 or GlobalVars.level==9:
		await get_tree().create_timer(0.5).timeout
		obstacle = randi_range(GlobalVars.level - 1, GlobalVars.level)
	else:
		obstacle = GlobalVars.level
	
	##CHANGE TRAILS
	if Input.is_action_just_pressed("space"):
		shielder.upsidedown()
		cooldown=0
		timer.start()
		
	if Input.is_action_just_released("space"):
		if cooldown !=1:
			if shielder.trails==0:
				$run/AnimationPlayer.play("down")
				await get_tree().create_timer(1).timeout
				shielder.trails=1
			else:
				$run/AnimationPlayer.play("up")
				await get_tree().create_timer(1).timeout
				shielder.trails=0
			cooldown=0
		if cooldown ==1:
			shielder.back()
			cooldown=0
		shielder.back()
	##RANDOMIZE THE OBSTACLES
	match obstacle:
		1:
			obstacles._rocks()
			move_toward(obstacles.position.x,-300,delta*100)
			


func _on_area_2d_area_entered(area):
	area.get_parent().queue_free()
