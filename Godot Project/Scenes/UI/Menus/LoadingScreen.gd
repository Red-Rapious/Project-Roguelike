extends Control

func _ready():
	if not global.show_loading_screen:
		start()
	pass

	
func start():
	get_tree().change_scene("Scenes/UI/Menus/TitleScreen.tscn")
	pass
	

func _on_Timer_timeout():
	start()
	pass 
