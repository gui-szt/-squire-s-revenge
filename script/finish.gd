extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.has_method("back"):
		GlobalVars.level +=1
		await get_tree().create_timer(0.4).timeout
		get_tree().change_scene_to_file("res://scenes/map.tscn")

func _on_area_2d_area_entered(area):
	area.get_parent().queue_free()
