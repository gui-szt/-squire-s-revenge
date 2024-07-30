extends Node2D

var cross =0

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x= randi_range(150,330)

func move(delta):
	position.x += -150*delta
	if cross==1:
		position.y +=120*delta
	if cross==0:
		position.y -=120*delta
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)

func _on_area_2d_body_entered(body):
	if body.has_method("back"):
		body.get_node("AnimatedSprite2D").play("death")
		body.get_node("CollisionShape2D").queue_free()
		await get_tree().create_timer(1.0).timeout
		body.queue_free()
		get_parent().get_parent().get_node("game_over").get_node("AnimationPlayer").play("new_animation")
