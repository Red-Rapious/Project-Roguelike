tool
extends Button

export var player_type = "Knight"

func _ready():
	text = player_type
	pass
	
func _on_Button_pressed():
	global.player_type = player_type
	get_tree().change_scene("res://Scenes/Rooms/RoomAssembly.tscn")
	pass