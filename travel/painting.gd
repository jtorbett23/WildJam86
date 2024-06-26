extends Area2D

@export var art_index : int = 1
@export var frame_index : int = 1


var canvas_info: Dictionary = {
	1 : {"size": Vector2(84,107), "pos": Vector2(-5,-3)},
	2 : {"size": Vector2(71, 71), "pos": Vector2(-4,-10)},
	3 : {"size": Vector2(72,72), "pos": Vector2.ZERO}
	
}

var value 
var is_placed = true
var is_forged = false
var is_locked = false
var painting_info

@onready var art : Sprite2D = $Art
@onready var frame : Sprite2D = $Frame

@onready var status = $"../../UI/Status"

func _ready():
	painting_info = GameData.get_value("Paintings", art_index)
	value = painting_info["value"]
	var frame_path = "res://assets/art/frame-{0}.png".format({"0": str(frame_index)})
	frame.texture = load(frame_path)
	#check for the painting
	#is there a painting placed
	#is it the real or the forged
	if(painting_info["is_placed"] == true):
		var art_path
		if(painting_info["is_forged"] == true):
			art_path = "./painting-{0}-forged.png".format({"0": str(art_index)})
			var image = Image.load_from_file(art_path)
			art.texture = ImageTexture.create_from_image(image)
		else:
			art_path = "res://assets/art/painting/painting-{0}.png".format({"0": str(art_index)})
			art.texture = load(art_path)
		art.position = canvas_info[frame_index]["pos"]
		art.scale = canvas_info[frame_index]["size"] / art.texture.get_size()
	is_placed = painting_info["is_placed"]
	is_forged = painting_info["is_forged"]

func update_art(placed_status, forged_status):
	is_placed = placed_status
	is_forged = forged_status
	painting_info["is_placed"] = placed_status
	painting_info["is_forged"] = forged_status
	GameData.set_value("Paintings", art_index, painting_info)
	
	if(is_placed == false):
		art.visible = false
	elif(is_placed and is_forged):
		GameData.money += value
		var peak_snr = painting_info["peak_snr"]
		var new_sus = 0
		if(peak_snr < GameData.threshold):
			new_sus = floor(GameData.threshold - peak_snr)
		GameData.sus += new_sus
		status.update_text()
		art.visible = true
		is_locked = true
		var forged_art_path = "./painting-{0}-forged.png".format({"0": str(art_index)})
		var image = Image.load_from_file(forged_art_path)
		art.texture = ImageTexture.create_from_image(image)
		art.position = canvas_info[frame_index]["pos"]
		art.scale = canvas_info[frame_index]["size"] / art.texture.get_size()
