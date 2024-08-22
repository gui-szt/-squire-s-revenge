extends Node2D
const CROSS_F=preload("res://scenes/croos_fall.tscn")
const CROSS_R=preload("res://scenes/cross_rotation.tscn")
var m =0
var moment
const SWORD = preload("res://scenes/sword.tscn")
var z =0
var y
var level= GlobalVars.level
var time =1
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVars.load_data()
	level= GlobalVars.level
	$AudioStreamPlayer.play()
	$Timer.start()
	$fade.play("fade_in")
	if level ==3:
		get_node("medal/AnimatedSprite2D").play("staff")
	if level ==6:
		get_node("medal/AnimatedSprite2D").play("cross")
		while time==1:
			await get_tree().create_timer(4).timeout
			moment=randi_range(1,3)
	if level ==9:
		get_node("medal/AnimatedSprite2D").play("sword")
		while time==1:
			await get_tree().create_timer(3).timeout
			moment=randi_range(1,3)
func mage():
	if y==1:
		await get_tree().create_timer(4).timeout
		match moment:
			1:
				if z==0:
					$mage/AnimatedSprite2D.play("fire")
					y=0
			2:
				if z==0:
					$mage/AnimatedSprite2D.play("rocks")
					y=0
			3:
				if z==0:
					$mage/AnimatedSprite2D.play("default")
					y=0
	await get_tree().create_timer(2).timeout
	y=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mage()
	if level==7 or level==8 or level==9:
		await get_tree().create_timer(1).timeout 
		if level ==9:
			if m<2:
				call_swords()
		else:
			if m<3:
				call_swords()
			


func _on_timer_timeout():
	$finish.play("new_animation")
	


func _on_area_2d_body_entered(body):
	$mage/AnimatedSprite2D.stop()
	Engine.time_scale=0.5
	$Mage_anim.play("get_medal")
	z=1
	$mage/AnimatedSprite2D.play("death")
	body.get_node("CollisionShape2D").queue_free()
	$AudioStreamPlayer2.play()
	await get_tree().create_timer(0.7).timeout
	$fade.play("fade_out")
	await get_tree().create_timer(0.6).timeout
	if level>=9:
		GlobalVars.level +=1
		GlobalVars.save_game
		Engine.time_scale=1
		get_tree().change_scene_to_file("res://scenes/end.tscn")
	else :
		GlobalVars.level +=1
	GlobalVars.save_game
	Engine.time_scale=1
	get_tree().change_scene_to_file("res://scenes/map.tscn")

func call_swords():
	var instance = SWORD.instantiate()
	get_node("obs").add_child(instance)
	instance.visible= true
	m+=1
	return instance



func _on_spawn_fire_rock_change_1():
	if z==0:
		moment=2


func _on_spawn_fire_rock_change_2():
	if z==0:
		moment=1

