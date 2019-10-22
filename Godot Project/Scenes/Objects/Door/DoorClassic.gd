tool
extends "res://Scenes/Objects/ObjectClassic.gd"

var opened = true
export var top_left = true

signal opening()
signal closing()

func _ready():
	set_collision_shapes()
	update()
	pass
	
func _process(delta):
	if not player_collapse:
		pass
		
	if top_left:
		if $InteractArea2.player_collapse and not player_collapse:
			player_quit()
	else:
		if not $InteractArea2.player_collapse and  player_collapse:
			player_quit()
	pass
	
func update():
	if opened:
		$Sprite.set_visible(false)
		$Sprite2.set_visible(true)
		$CollisionShape2D.disabled = true
	else:
		$Sprite.set_visible(true)
		$Sprite2.set_visible(false)
		$CollisionShape2D.disabled = false
	pass
	
func set_collision_shapes():
	$InteractArea/CollisionShape2D.get_shape().set_extents(Vector2(16,4))
	$InteractArea/CollisionShape2D.position = Vector2(0,-12)
	$InteractArea2/CollisionShape2D.get_shape().set_extents(Vector2(16,4))
	$InteractArea2/CollisionShape2D.position = Vector2(0,12)
	
	$InteractArea/CollisionShape2D.rotation_degrees=0
	$InteractArea2/CollisionShape2D.rotation_degrees=0
	pass
	
func open():
	if not opened:
		opened=true
		update()
		emit_signal("opening")
	pass
	
func close():
	if opened:
		opened=false
		update()
		emit_signal("closing")
	pass
	
# warning-ignore:unused_argument
func on_interact(player):
	#open()
	pass
	
func player_quit():
	if get_parent().get_parent().has_method("start_fight"):
		get_parent().get_parent().start_fight()
