extends Control

var finish =0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer2.play("fade_in")
	await  get_tree().create_timer(0.3).timeout
	$AnimationPlayer.play("new_animation")
	await $AnimationPlayer.animation_finished
	finish=1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_touch_screen_button_pressed():
	if finish==1:
		$AnimationPlayer2.play("fade_out")
		await get_tree().create_timer(1.4).timeout
		GlobalVars.level +=1
		get_tree().change_scene_to_file("res://scenes/game.tscn")
