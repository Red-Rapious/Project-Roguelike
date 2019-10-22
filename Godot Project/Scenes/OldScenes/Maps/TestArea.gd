#extends "res://Scenes/Maps/MapClassic.gd"
extends Node2D

var path

#onready var monster_pos = $Devil.global_position
onready var player_pos = $Knight.global_position

	
func _process(delta):
#	monster_pos = $Devil.global_position
	player_pos = $Knight.global_position
	new_path()
	pass
	
func new_path():
#	path= $Navigation2D.get_simple_path(monster_pos, player_pos)
#	$Devil.set_path(path)
#	$Line2D.points = path
	pass