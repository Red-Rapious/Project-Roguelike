extends "res://Scenes/OldScenes/Objects/ObjectClassic.gd"

export var weapon_name = "Knife"
var loaded = true

func _ready():
	$Weapon.texture = load("res://Assets/Weapons/"+weapon_name + ".png")
	$CollisionShape2D.get_shape().set_extents(Vector2(16,16))
	pass

func on_collapse(body):
	if body.name == global.player_type and loaded:
		body.set_actual_weapon(weapon_name)
		$Weapon.visible = false
		loaded = false
	pass
