extends "res://Scenes/Objects/ObjectClassic.gd"

var opened = false
export var vertical=false

func _ready():
	$CollisionShape2D.disabled=false
	$CollisionShape2D.get_shape().set_extents(Vector2(16,32))
	if vertical:
		$CollisionShape2D.rotation_degrees = 90
	$Sprite.visible = true
	$Sprite2.visible = false

func on_collapse(body):
	if body.name == global.player_type:
		open()
	pass
	
func open():
	if not opened:
		opened = true
		$CollisionShape2D.disabled=true
		$Sprite.visible = false
		$Sprite2.visible=true
	pass
