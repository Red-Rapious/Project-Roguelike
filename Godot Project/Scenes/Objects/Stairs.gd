extends "res://Scenes/Objects/ObjectClassic.gd"

onready var shape = Shape2D

func _ready():
	$CollisionShape2D.get_shape().set_extents(Vector2(12,12))
	$InteractArea/CollisionShape2D.get_shape().set_extents(Vector2(24,24))
	$Label.set_visible(false)
	pass
	
func _process(delta):
	$Label.set_visible(false)
	
func on_interact(player):
	get_tree().change_scene("Scenes/UI/Menus/EndLevelScreen.tscn")
	pass
	
func on_collapse(body):
	$Label.set_visible(false)
	if body.is_in_group("player"):
		$Label.set_visible(true)
	pass
	

