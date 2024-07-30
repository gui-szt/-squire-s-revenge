extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	$timer_rock.start()
	$timer_rock.timeout.connect(swords)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func swords():
		var x = randi_range(1, 5)
		await get_tree().create_timer(randi_range(3, 4)).timeout
		match x:
			1:
				$Sprite2D.play("spear")
				rotation=0
				$Area2D/CollisionShape2D3.visible=true
				$Area2D/CollisionShape2D4.visible= true
				$AnimationPlayer.play("lunge_0")
			2:
				$Sprite2D.play("small")
				$Area2D/CollisionShape2D2.visible=true
				if GlobalVars.level==7 or GlobalVars.level==9:
					rotation=0
					$AnimationPlayer.play("lunge_1")
			3:
				$Area2D/CollisionShape2D2.visible=true
				$Sprite2D.play("small")
				if GlobalVars.level==7 or GlobalVars.level==9:
					rotation=0
					$AnimationPlayer.play("lunge_2")
			4:
				$Area2D/CollisionShape2D2.visible=true
				$Sprite2D.play("small")
				if GlobalVars.level==8 or GlobalVars.level==9:
					$AnimationPlayer.play("cut_down")
			5:
				$Area2D/CollisionShape2D2.visible=true
				$Sprite2D.play("small")
				if GlobalVars.level==8 or GlobalVars.level==9:
					$AnimationPlayer.play("cut_up")
					
		$Area2D/CollisionShape2D2.visible=false
		$Area2D/CollisionShape2D3.visible=false
		$Area2D/CollisionShape2D4.visible= false
		$timer_rock.start()


func _on_area_2d_body_entered(body):
	if body.has_method("back"):
		body.get_node("AnimatedSprite2D").play("death")
		body.get_node("CollisionShape2D").queue_free()
		await get_tree().create_timer(1.0).timeout
		body.queue_free()
		get_parent().get_parent().get_node("game_over").get_node("AnimationPlayer").play("new_animation")
