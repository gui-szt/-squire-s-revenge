extends Node
var level =4
var progress =4
var score =0
var FILE= "use://data.json"

func _ready():
	load_data()
	
func _process(delta):
	progress=level

func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var data={
		"level" : level,
		"score" : score
	}
	var json_string = JSON.stringify(data)
	save_file.store_line(json_string)
	
	
func load_data():
	if not FileAccess.file_exists("user://savegame.save"):
		return 
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var node_data = json.get_data()
		for i in node_data.keys():
			if i =="level":
				level= node_data[i]
			if i == "score":
				score= node_data[i]
func save_score():
	save_game()
