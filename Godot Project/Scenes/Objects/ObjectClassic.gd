extends StaticBody2D

var bodies
var player_collapse = false

func _process(delta):
	player_collapse=false
	bodies = $InteractArea.get_overlapping_bodies()
	for body in bodies:
		on_collapse(body)
		if body.is_in_group("player"):
			on_player_collapse()
			player_collapse=true
			if Input.is_action_pressed("ui_interact"):
				on_interact(body)
	pass


func on_collapse(body):
	pass
	
func on_player_collapse():
	pass

func on_interact(player):
	pass
	