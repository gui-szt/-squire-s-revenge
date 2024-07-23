extends Node

var level = 1
var progress = 0
var obstacle = 1
const SAVEFILE= "user://save.data"
func save_progress():
	var file = FileAccess.open(SAVEFILE,FileAccess.READ_WRITE)
	file.store_32(progress)
	if file != null:
		progress = file.get_32()
	else:
		progress = 0
