extends Node2D

var speed = -200

# Called when the node enters the scene tree for the first time.
func _ready():
	var x=randi_range(1,2)
	match x:
		1:
			$AnimationPlayer.play("down")
		2:
			$AnimationPlayer.play("up")
			
	await get_tree().create_timer(2.6).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation+=0.2
	position.x += speed *delta


func _on_area_2d_body_entered(body):
	if body.has_method("back"):
		body.get_node("AnimatedSprite2D").play("death")
		body.get_node("CollisionShape2D").queue_free()
		await get_tree().create_timer(1.0).timeout
		body.queue_free()
		get_parent().get_parent().get_node("game_over").get_node("AnimationPlayer").play("new_animation")
