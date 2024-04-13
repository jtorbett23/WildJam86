extends Node2D

var color = Color.BLACK	
var radius = 20

var draw_data :Array = []
var min_pos : Vector2
var max_pos : Vector2

func _draw():
	for pos in draw_data:
		draw_circle(pos, radius, color)

# Called when the node enters the scene tree for the first time.
func _ready():


	var background : Sprite2D = $"Background"
	var background_size = background.get_rect().size * background.transform.get_scale()
	min_pos = background.global_position
	max_pos = min_pos + background_size
	print(min_pos, max_pos)

	pass # Replace with function body.


func is_on_canvas(mouse_pos) -> bool:
	#within min
	if (mouse_pos.x > min_pos.x) and (mouse_pos.y > min_pos.y):
		#within max
		if (mouse_pos.x < max_pos.x) and (mouse_pos.y < max_pos.y):
			return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = get_global_mouse_position()
	if Input.is_action_pressed("draw") and is_on_canvas(pos):
		draw_data.append(pos)
	elif Input.is_action_just_pressed("clear"):
		draw_data = []
	queue_redraw()
	pass
