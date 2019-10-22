extends Control

func _ready():
	$VBoxContainer/TryAgain.connect("pressed", $VBoxContainer/TryAgain, "_on_Button_pressed")
	global.reset()


