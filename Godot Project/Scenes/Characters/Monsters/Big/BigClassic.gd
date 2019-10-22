extends "res://Scenes/Characters/Monsters/MonsterClassic.gd"

export var attackHitbox = 3
export var attackRadius = 9
export var hitbox = 15
export var hitboxRadius = 9

func _ready():
	$CollisionShape2D.get_shape().set_height(hitbox)
	$CollisionShape2D.get_shape().set_radius(hitboxRadius)
	$AttackHitbox/PlayerDetection.get_shape().set_height(attackHitbox)
	$AttackHitbox/PlayerDetection.get_shape().set_radius(attackRadius)
	pass
	
func dead_sound():
	Global.play_sound_instance(2,-10)
	pass
