extends Node
var level =1
var progress =1

const SAVEFILE= "user://savefile.save"

func _ready():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if file != null:
		level=file.get_var(true)
		progress=level
		if level>9:
			level =1
			save_progress()
	else:
		level=1
		save_progress()
	
func save_progress():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	file.store_var(level)


