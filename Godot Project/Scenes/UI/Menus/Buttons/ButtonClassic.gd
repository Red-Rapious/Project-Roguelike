
extends Button
tool
export var nextScene = "UI/Menus/TitleScreen"
export var buttonText = "Text"

func _ready():
	text = buttonText
	pass
	
func _on_Button_pressed():
	if nextScene == "Quit":
		get_tree().quit()
	else:
		get_tree().change_scene("res://Scenes/"+nextScene+".tscn")
	pass

