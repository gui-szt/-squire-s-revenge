extends Node2D

var stop=0
var level

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVars.load_data()
	level=GlobalVars.level
	$AnimationPlayer.play("fade_in")
	$AudioStreamPlayer.play()
	await get_tree().create_timer(1).timeout
	stop=1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if level==1 and stop==1:
		$AnimationPlayer.play("0-1")
		stop =0
	if level==2 and stop==1:
		$AnimationPlayer.play("1-2")
		stop =0
	if level==3 and stop==1:
		$AnimationPlayer.play("2-3")
		stop =0
	if level==4 and stop==1:
		$AnimationPlayer.play("3-4")
		stop =0
	if level==5 and stop==1:
		$AnimationPlayer.play("4-5")
		stop =0
	if level==6 and stop==1:
		$AnimationPlayer.play("5-6")
		stop =0
	if level==7 and stop==1:
		$AnimationPlayer.play("6-7")
		stop =0
	if level==8 and stop==1:
		$AnimationPlayer.play("7-8")
		stop =0
	if level== 9 and stop==1:
		$AnimationPlayer.play("8-9")
		stop =0
	await get_tree().create_timer(1.4).timeout
	
	if Input.is_action_pressed("space"):
		if level==1:
			$AnimationPlayer.play("fade_out")
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_file("res://scenes/level/level_1_1.tscn")
		if level==2:
			$AnimationPlayer.play("fade_out")
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_file("res://scenes/level/level_1_2.tscn")
		if level==3:
			$AnimationPlayer.play("fade_out")
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_file("res://scenes/level/level_1_3.tscn")
		if level==4:
			$AnimationPlayer.play("fade_out")
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_file("res://scenes/level/level_2_1.tscn")
		
		if level==5:
			$AnimationPlayer.play("fade_out")
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_file("res://scenes/level/level_2_2.tscn")
		
		if level==6:
			$AnimationPlayer.play("fade_out")
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_file("res://scenes/level/level_2_3.tscn")
		if level==7:
			$AnimationPlayer.play("fade_out")
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_file("res://scenes/level/level_3_1.tscn")
		if level==8:
			$AnimationPlayer.play("fade_out")
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_file("res://scenes/level/level_3_2")
		if level==9:
			$AnimationPlayer.play("fade_out")
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_file("res://scenes/level/level_3_3.tscn")
		



