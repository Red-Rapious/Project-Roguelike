extends Area2D

var bodies

# warning-ignore:unused_argument
func _process(delta):
	bodies = get_overlapping_bodies()
	for body in bodies:
		on_collapse(body)
	pass
	
# warning-ignore:unused_argument
func on_collapse(body):
	pass
