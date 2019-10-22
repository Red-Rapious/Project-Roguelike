extends Area2D

var bodies
var player_collapse

func _process(delta):
	player_collapse=false
	bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			player_collapse=true
	pass
