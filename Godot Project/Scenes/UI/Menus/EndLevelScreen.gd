extends Control

var newrec = false

func _ready():
	$VBoxContainer/LevelComplete.text = "Level "+str(global.world)+"-"+str(global.level)+" completed!"
	for button in $VBoxContainer/Buttons.get_children():
		button.connect("pressed", button, "_on_Button_pressed")
	$VBoxContainer/Center/Text/Time.text="Time: "+str(global.set_time())
	$VBoxContainer/Center/Text/Gold.text="Gold ernead: "+str(global.gold-global.old_gold)
	$VBoxContainer/Center/Text/Kills.text="Killed monsters: "+str(global.monster_killed)
	$VBoxContainer/Center/Text/LostHP.text="Lost HP: "+str(global.lost_hp)
	global.next_level()
	
	if not newrec:
		$VBoxContainer/Center/Text/NewRec.text = " "
	pass 

