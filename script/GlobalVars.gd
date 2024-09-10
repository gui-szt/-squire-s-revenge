extends Node
var level=0
var progress=0
var score =0
##const SAVE_PATH : String = "user://savegame.bin"
const SAVEFILE: String = "user://savegame.save"

func save_game():
	var save = {
		"level" : level,
		"score" : score,
		"progress" : progress
	}
	var File = FileAccess.open(SAVEFILE,FileAccess.WRITE)
	var json = JSON.stringify(save)
	File.store_line(json)
func load_data():
	var File = FileAccess.open(SAVEFILE,FileAccess.READ)
	if not File.file_exists(SAVEFILE):
		save_game()
	while (File.get_position()< File.get_length()):
		var file_s=File.get_line()
		var json=JSON.new()
		var parsed = json.parse(file_s)
		var data = json.get_data()
		for i in data.keys():
			if i == "level":
				level = data[i]
			if i== "score":
				score= data[i]
			if i ==" progress":
				progress = data[i]
func save_score():
	save_game()
