extends "res://Scenes/Characters/Monsters/MonsterClassic.gd"

export var attackHitbox = 0.5
export var attackRadius = 8
export var hitbox = 0.6
export var hitboxRadius = 9

func _ready():
	$CollisionShape2D.get_shape().set_height(hitbox)
	$CollisionShape2D.get_shape().set_radius(hitboxRadius)
	$AttackHitbox/PlayerDetection.get_shape().set_height(attackHitbox)
	$AttackHitbox/PlayerDetection.get_shape().set_radius(attackRadius)
	pass
	
func dead_sound():
	Global.play_sound_instance(0,-10)
	pass

