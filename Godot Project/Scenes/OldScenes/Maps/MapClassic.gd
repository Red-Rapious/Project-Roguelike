extends Node2D

var scene = load("res://Scenes/Characters/Players/"+global.player_type+".tscn")
var instancep
var player
export var start_position = Vector2(0,0)

func _ready():
	instancep = scene.instance()
	add_child(instancep)
	player = instancep
	player.position = start_position
	
	get_tree().call_group("torch", "set_visible", options.use_light)
	$CanvasModulate.set_visible(options.use_light)
	pass 

func _on_PauseMenu_about_to_show():
	$HUD/Control.visible=false
	pass


func _on_PauseMenu_popup_hide():
	$HUD/Control.visible=true
	pass

func new_path(start):
	return $Navigation2D.get_simple_path(start, global.position)