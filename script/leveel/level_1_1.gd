extends Node2D

var level=GlobalVars.level
var m =0
@onready var SWORD=preload("res://scenes/sword.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$finish.play("fade_in")
	$Timer.start()
	$AudioStreamPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if level==7 or level==8 or level==9:
		await get_tree().create_timer(0.5).timeout 
		if m<2:
			call_swords()
			


func _on_timer_timeout():
	$finish.play("finish")
	GlobalVars.level +=1
	GlobalVars.save_game()
	await get_tree().create_timer(1.3).timeout
	get_tree().change_scene_to_file("res://scenes/map.tscn")
	
func call_swords():
	var instance =SWORD.instantiate()
	get_node("obs").add_child(instance)
	instance.visible= true
	m+=1
	return instance
