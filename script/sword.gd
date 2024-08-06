extends Node2D
var level= GlobalVars.level
var t=0
var progress= GlobalVars.progress
var x 

# Called when the node enters the scene tree for the first time.
func _ready():
	swords()
	$Timer.start()
	$Timer.timeout.connect(swords)

func swords():
	match x:
		1:
			if t==0:
				$Sprite2D.play("spear")
				rotation=0
				$AnimationPlayer.play("lunge_0")
				$Area2D/spear.visible=true
				await $AnimationPlayer.animation_finished
				$Area2D/spear.visible=false
				t=1
		2:
			if t==0:
				$Sprite2D.play("small")
				if level==7 or level==9 or progress>=9:
					rotation=0
					$AnimationPlayer.play("lunge_1")
					$Area2D/spear.visible=true
					await $AnimationPlayer.animation_finished
					$Area2D/spear.visible=false
					t=1
		3:
			if t==0:
				$Sprite2D.play("small")
				if level==7 or level==9 or progress>=9:
					rotation=0
					$AnimationPlayer.play("lunge_2")
					$Area2D/spear.visible=true
					await $AnimationPlayer.animation_finished
					$Area2D/spear.visible=false
					t=1
					
		4:
			if t==0:
				$Sprite2D.play("small")
				if level==8 or level==9 or progress>=9:
					$AnimationPlayer.play("cut_down")
					$Area2D/sword.visible=true
					await $AnimationPlayer.animation_finished
					$Area2D/sword.visible=false
					t=1
		5:
			if t==0:
				$Sprite2D.play("small")
				if level==8 or level==9 or progress>=9:
					$AnimationPlayer.play("cut_up")
					$Area2D/sword.visible=true
					await $AnimationPlayer.animation_finished
					$Area2D/sword.visible=false
					t=1
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.has_method("back"):
		body.get_node("AnimatedSprite2D").play("death")
		body.get_node("CollisionShape2D").queue_free()
		await get_tree().create_timer(1.0).timeout
		body.queue_free()
		get_parent().get_parent().get_node("game_over").visible=true
		get_parent().get_parent().get_node("game_over").get_node("AnimationPlayer").play("new_animation")






func _on_timer_timeout():
	randomize()
	x= randi_range(1, 5)
	t=0
	swords()
	$Timer.start()
	
