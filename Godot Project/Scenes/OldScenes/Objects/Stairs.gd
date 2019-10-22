extends "res://Scenes/OldScenes/Objects/ObjectClassic.gd"

#export var nextMap = "Map1"
#signal scene_changed(old_weapon)

func _ready():
	$CollisionShape2D.get_shape().set_extents(Vector2(32,32))
	pass 
	
# warning-ignore:unused_argument
func on_collapse(body):
	# warning-ignore:return_value_discarded
	get_tree().change_scene("Scenes/UI/Menus/EndLevelScreen.tscn")
	#emit_signal("scene_changed", get_tree().get_current_scene().get_node(global.player_type).get_weapon())
	
	#global.pv = get_tree().get_current_scene().get_node(global.player_type).getPv()
	#global.weapon1 = get_tree().get_current_scene().get_node(global.player_type).get_weapon()
	#global.weapon2 = get_tree().get_current_scene().get_node(global.player_type).get_weapon()
	pass
