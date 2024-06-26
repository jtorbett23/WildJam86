extends ColorRect

@onready var yes_button = $Yes
@onready var no_button = $No
@onready var question = $Question
@onready var info = $Info


var topic = null
var target = null
signal response(response_choice, topic, target)

func _ready():
	no_button.connect("pressed", handle_response.bind("no"))
	yes_button.connect("pressed", handle_response.bind("yes"))


func setup(action, info_text, new_target):
	var question_text = "Are you sure you want to {0}?".format({"0": action})
	question.text = question_text
	info.text = info_text
	topic = action
	target = new_target
	self.show()

func handle_response(choice):
	self.hide()
	response.emit(choice, topic, target)
	topic = null



