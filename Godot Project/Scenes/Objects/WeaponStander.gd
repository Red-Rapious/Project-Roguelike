tool
extends "res://Scenes/Objects/ObjectClassic.gd"

export var weapon_name = "Knife"
var loaded = true

func _ready():
	$Weapon.texture = load("res://Assets/Weapons/"+weapon_name + ".png")
	$CollisionShape2D.get_shape().set_extents(Vector2(8,8))
	$InteractArea/CollisionShape2D.get_shape().set_extents(Vector2(16,16))
	$Price.set_visible(false)
	$Price.set_text(str(price.list[weapon_name])+" PO")
	pass

func _process(delta):
	$Price.set_visible(false)

func on_collapse(body):
	if body.is_in_group("player") and loaded:
		$Price.set_visible(true)
	pass

func on_interact(body):
	if weapon_name != global.weapon1 and weapon_name != global.weapon2:
		if global.gold>=price.list[weapon_name]:
			global.gold-=price.list[weapon_name]
			body.set_actual_weapon(weapon_name)
			$Weapon.visible = false
			loaded = false
			get_tree().call_group("shop_keeper", "start_thanks")
		else:
			get_tree().call_group("shop_keeper", "start_scam")
	pass
