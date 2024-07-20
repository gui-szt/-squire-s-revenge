extends Node2D
var progress = 0
var cooldown =0

@onready var timer = $run/Timer
@onready var shielder = $run/shielder
const SAVEFILE= "user://save.data"

func save_progress():
	var file = FileAccess.open(SAVEFILE,FileAccess.READ_WRITE)
	file.store_32(progress)
	if file != null:
		progress = file.get_32()
	else:
		progress = 0

func _process(delta):
	if Input.is_action_pressed("space"):
		timer.start()
		shielder.upsidedown()
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
		shielder.back()
	cooldown=0


func _on_timer_timeout():
	cooldown=1
