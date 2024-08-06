extends Node2D
var m =0
var progress= GlobalVars.progress
var SWORD=preload("res://scenes/sword.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if m<2:
		call_swords()

func call_swords():
	var instance = SWORD.instantiate()
	get_parent().get_node("obs").add_child(instance)
	instance.visible= true
	m+=1
	return instance
