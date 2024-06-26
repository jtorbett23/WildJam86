extends Control

@onready var return_button = $Return

@onready var text_label = $EndingText

@onready var results_holder = $VFlowContainer

var result_ref = preload("res://result.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	AudioManager.play_music("daytime.mp3")
	Camera.set_static()
	var painting_ids = get_final_paintings_ids()
	for id in painting_ids:
		var new_result = result_ref.instantiate()
		results_holder.add_child(new_result)
		new_result.setup_result(id)
		

	#check if painting was not placed back
	check_for_no_replacements()
	var money_text = "did not make enough money"
	var reached_target = false
	if(GameData.money >= GameData.money_target):
		money_text = "made enough money"
		reached_target = true
	var not_caught = roll_caught(5,3, GameData.sus)

	var caught_text = "got caught"
	if(not_caught and not reached_target):
		caught_text = "escaped but is now on the run for the debt"
	elif(not_caught and reached_target):
		caught_text = "escaped and is free"
	elif(not not_caught and not reached_target):
		"got caught and still got debts"
	elif(not not_caught and reached_target):
		"got caught but is debt free"
	
	return_button.connect("pressed", handle_return)
	var text = "
	Thank you for playing.\n
	You earned £{0} with the target of {4}
	Your final Suspicion Level was {1}% - Any non-returned paintings adds 20%
	Herb {2} and {3}.
	".format({"0": GameData.money, "1": GameData.sus, "2": money_text, "3": caught_text, "4": GameData.money_target})
	text_label.text = text
	print(GameData.get_dict("Paintings"))

func get_final_paintings_ids():
	var p_ids = []
	var paintings = GameData.get_dict("Paintings")
	for key in paintings.keys():
		if(paintings[key]["is_placed"] == true and paintings[key]["is_forged"] == true):
			p_ids.append(key)
	return p_ids


func check_for_no_replacements():
	var paintings = GameData.get_dict("Paintings")
	for p in paintings.values():
		if(p["is_placed"] == false):
			GameData.sus += 20
			GameData.money += p["value"]


func roll_caught(total_rolls, amount_needed, threshold):
	var failing_rolls = 0
	for i in range(0, total_rolls):
		var roll = rng.randi_range(0,100)
		if(roll < threshold):
			failing_rolls += 1
	if(failing_rolls >= amount_needed):
		return false
	else:
		return true


func handle_return():
	Camera.transition.fade("Main")
	queue_free()
