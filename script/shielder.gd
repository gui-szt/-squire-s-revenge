extends CharacterBody2D

var change =0
var trails = 0
var cooldown =0
const run=preload("res://assets/Music/sfx/runmp3.wav")
const hurt= preload("res://assets/Music/sfx/hurt.wav")
@onready var timer = $Timer

func _ready():
	position.y = -55
	position.x=-80
	$AudioStreamPlayer.stream = run
	$AudioStreamPlayer.play()
	
func upsidedown():
	$AnimatedSprite2D.flip_v = true
	if trails==0:
		position.y = -24
	
	else:
		position.y = 66
		
func back():
	$AnimatedSprite2D.flip_v= false
	if trails==0:
		position.y = -55
	else:
		position.y = 35
	

func _on_timer_timeout():
	cooldown=1

func _process(delta):
	##CHANGE TRAILS
	if Input.is_action_just_pressed("space"):
		upsidedown()
		cooldown=0
		timer.start()
		
	if Input.is_action_just_released("space"):
		if cooldown !=1:
			if trails==0:
				$AnimationPlayer.play("down")
				$AudioStreamPlayer.stop()
				$AudioStreamPlayer2.play()
				await get_tree().create_timer(0.5).timeout
				$AudioStreamPlayer.play()
				trails=1
			else:
				$AnimationPlayer.play("up")
				$AudioStreamPlayer.stop()
				$AudioStreamPlayer2.play()
				await get_tree().create_timer(0.5).timeout
				$AudioStreamPlayer.play()
				trails=0
			cooldown=0
		if cooldown ==1:
			back()
			
			cooldown=0
		back()

func _on_animated_sprite_2d_animation_changed():
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer.stream= hurt
	$AudioStreamPlayer.volume_db=-5
	$AudioStreamPlayer.play()
	
