extends Node2D
const CROSS_F=preload("res://scenes/croos_fall.tscn")
const CROSS_R=preload("res://scenes/cross_rotation.tscn")
var m =0
const SWORD = preload("res://scenes/sword.tscn")
var z =3
var y
# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	$Timer.start()
	$fade.play("fade_in")
	if GlobalVars.level ==3:
		get_node("medal/AnimatedSprite2D").play("staff")
	if GlobalVars.level ==6:
		get_node("medal/AnimatedSprite2D").play("cross")
	if GlobalVars.level ==9:
		get_node("medal/AnimatedSprite2D").play("sword")
func mage():
	if y==1:
		await get_tree().create_timer(2).timeout
		match z:
			1:
				$mage/AnimatedSprite2D.play("fire")
				y=0
			2:
				$mage/AnimatedSprite2D.play("rocks")
				y=0
			3:
				$mage/AnimatedSprite2D.play("default")
				y=0
	await get_tree().create_timer(2).timeout
	y=1
	z= randi_range(1, 3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mage()
	if GlobalVars.level==7 or GlobalVars.level==8 or GlobalVars.level==9:
		await get_tree().create_timer(1).timeout 
		if m<3:
			call_swords()
			


func _on_timer_timeout():
	$finish.play("new_animation")


func _on_area_2d_body_entered(body):
	Engine.time_scale=0.5
	$Mage_anim.play("get_medal")
	body.get_node("CollisionShape2D").queue_free()
	$mage/AnimatedSprite2D.play("death")
	$AudioStreamPlayer2.play()
	await get_tree().create_timer(0.5).timeout
	$fade.play("fade_out")
	await get_tree().create_timer(0.6).timeout
	if GlobalVars.level==9:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	else :
		GlobalVars.level +=1
	GlobalVars.save_progress()
	Engine.time_scale=1
	get_tree().change_scene_to_file("res://scenes/map.tscn")

func call_swords():
	var instance = SWORD.instantiate()
	get_node("obs").add_child(instance)
	instance.visible= true
	m+=1
	return instance
