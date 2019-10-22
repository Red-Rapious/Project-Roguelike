tool
extends Popup

var on = false
var time=0

func _ready():
	$All/Top/Weapons/Name1.text=global.weapon1
	$All/Top/Weapons/Name2.text=global.weapon2
	for button in $All/Buttons.get_children():
		button.connect("pressed", button, "_on_Button_pressed")
	pass

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if on:
			hide()
		else:
			popup()
	pass 

func _on_PauseMenu_about_to_show():
	time=OS.get_unix_time()
	get_tree().paused=true
	on=true
	pass

func _on_PauseMenu_popup_hide():
	get_tree().paused=false
	global.set_room_time(global.room_start_time+OS.get_unix_time()-time)
	on=false
	pass
