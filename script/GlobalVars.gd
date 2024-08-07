extends Node
var level =1
var progress =1
var score =0
##const SAVE_PATH : String = "user://savegame.bin"
const SAVE_PATH : String = "res://savegame.bin"

func save_game()->void:
	var file =FileAccess.open(SAVE_PATH,FileAccess.WRITE)
	var data :Dictionary ={
		"level"= level,
		"progress"=progress,
		"score"= score
	}
	var jstr= JSON.stringify(data)
	file.store_line(jstr)

func load_data()->void:
	var file= FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return
	if file==null:
		return
	if FileAccess.file_exists(SAVE_PATH)== true:
		if not file.eof_reached():
			var current_line= JSON.parse_string(file.get_line())
			if current_line:
				level = current_line["level"]
				progress= current_line["progress"]
				score= current_line["score"]
func save_score():
	save_game()
