extends Node

var settings : Dictionary = {
	"music_level": 50,
	"sound_level": 50
}

var paintings_inital : Dictionary = {
	1 : {"is_placed": true, "is_forged": false, "value": 900, "peak_snr": 0},
	2 : {"is_placed": true, "is_forged": false, "value": 1000, "peak_snr": 0},
	3 : {"is_placed": true, "is_forged": false, "value": 800, "peak_snr": 0},
	4 : {"is_placed": true, "is_forged": false, "value": 1000, "peak_snr": 0},
	5 : {"is_placed": true, "is_forged": false, "value": 900, "peak_snr": 0},
	6 : {"is_placed": true, "is_forged": false, "value": 800, "peak_snr": 0},
	7 : {"is_placed": true, "is_forged": false, "value": 700, "peak_snr": 0},
	8 : {"is_placed": true, "is_forged": false, "value": 900, "peak_snr": 0},
}

var paintings : Dictionary = paintings_inital.duplicate(true)

var draw_data_inital : Dictionary = {
	1 : [],
	2 : [],
	3 : [],
	4 : [],
	5 : [],
	6 : [],
	7 : [],
	8 : [],
}

var draw_data : Dictionary = draw_data_inital.duplicate(true)


var prev_draw_data_inital  : Dictionary = {
	1 : [[]],
	2 : [[]],
	3 : [[]],
	4 : [[]],
	5 : [[]],
	6 : [[]],
	7 : [[]],
	8 : [[]],
}

var prev_draw_data : Dictionary = prev_draw_data_inital.duplicate(true)

var money = 0
var money_target = 3000
var sus = 0
var threshold = 20                                                                                                                                                                                                                                                                       

func set_value(dict_name, key, value) -> void:
	if(dict_name == "Settings"):
		if(key in settings.keys()):
			settings[key] = value
	elif(dict_name == "Paintings"):
		if(key in paintings.keys()):
			paintings[key] = value

func get_value(dict_name, key):
	if(dict_name == "Settings"):
		if(key in settings.keys()):
			return settings[key]
	elif(dict_name == "Paintings"):
		if(key in paintings.keys()):
			return paintings[key]
	elif(dict_name == "Draw"):
		if(key in draw_data.keys()):
			return draw_data[key]

func get_dict(dict_name):
	if(dict_name == "Settings"):
		return settings
	elif(dict_name == "Paintings"):
		return paintings
	elif(dict_name == "Draw"):
		return draw_data
	elif(dict_name == "Prev-Draw"):
		return prev_draw_data

func set_dict(dict_name, dict):
	if(dict_name == "Settings"):
		settings = dict
	elif(dict_name == "Paintings"):
		paintings = dict
	elif(dict_name == "Draw"):
		draw_data = dict
	elif(dict_name == "Prev-Draw"):
		prev_draw_data = dict
	
func reset_state():
	sus = 0
	money = 0
	paintings = paintings_inital.duplicate(true)
	draw_data = draw_data_inital.duplicate(true)
	prev_draw_data = prev_draw_data_inital.duplicate(true)

