extends Node2D

var s
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("_in")
	await get_tree().create_timer(1.3).timeout
	$Label2.visible =true

func _process(delta):
	if Input.is_action_pressed("space"):
		s=1
	if s==1:
		$Label3.visible=true
		await get_tree().create_timer(2.0).timeout
		$Button.visible =true

func _on_button_pressed():
	GlobalVars.progress +=1
	GlobalVars.level +=1
	GlobalVars.save_game()
	$AnimationPlayer.play("_out")
	await get_tree().create_timer(0.8).timeout
	get_tree().change_scene_to_file("res://scenes/map.tscn")
	
