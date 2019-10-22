extends Control

func _ready():
	for button in $HBoxContainer.get_children():
		button.connect("pressed", button, "_on_Button_pressed")
	pass 
