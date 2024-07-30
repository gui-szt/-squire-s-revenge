extends Node
var level :int =1
var progress =1

const SAVEFILE= "user://savefile.save"

func _ready():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if level==4:
		progress= file.get_float()
	if level ==7:
		progress= file.get_float()
	if level == 10:
		progress= file.get_float()
	if level >9:
		level=1
		save_progress()
	level=file.get_float()

func save_progress():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	file.store_float(level)


