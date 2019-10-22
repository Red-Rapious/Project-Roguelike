extends KinematicBody2D

export var dmg = 1
export var bump = 1
export var hitbox = Vector2(16,30)

var dir =  0
var bodies
var touched_monsters=false

signal no_touch()

func _ready():
	play("Idle")
	$Rotate/Sprite.rotation_degrees = 0
	$Rotate/Sprite.modulate = Color(1,1,1)
	#$Rotate/Sprite.position = Vector2(-3,-10)
	$Rotate.rotation_degrees=45
	$RightColl/CollisionShape2D.get_shape().set_extents(hitbox)
	$LeftColl/CollisionShape2D.get_shape().set_extents(hitbox)
	dir = get_parent().getDir()
	reorient()
	pass

# warning-ignore:unused_argument
func _process(delta):
	dir = get_parent().getDir()
	reorient()
	animations()
	pass

func play(anim):
	if $AnimationPlayer.current_animation != anim:
		$AnimationPlayer.play(anim)
	pass
	
func reorient():
	match dir:
		0:
			$Rotate.position.x = 16
			if $AnimationPlayer.current_animation != "AttackR" and $AnimationPlayer.current_animation != "AttackL":
				$Rotate.rotation_degrees = 45
		1:
			$Rotate.position.x = 2
			if $AnimationPlayer.current_animation != "AttackR" and $AnimationPlayer.current_animation != "AttackL":
				$Rotate.rotation_degrees=315
	pass
	
func attack():
	if get_parent().hitted == false and $AnimationPlayer.current_animation != "AttackR" and $AnimationPlayer.current_animation != "AttackL":
		match dir:
			0:
				bodies = $RightColl.get_overlapping_bodies()
				play("AttackR")
				for body in bodies:
					#if body.get_filename() == "res://Scenes/Characters/Monsters/MonsterClassic.tscn":
					if body is KinematicBody2D:
						get_parent().hitMonster(body)
						touched_monsters=true
			1:
				bodies = $LeftColl.get_overlapping_bodies()
				play("AttackL")
				for body in bodies:
					#if body.get_filename() == "res://Scenes/Characters/Monsters/MonsterClassic.tscn":
					if body is KinematicBody2D:
						get_parent().hitMonster(body)
						touched_monsters=true
		if not touched_monsters :
			emit_signal("no_touch")
		touched_monsters=false
	pass
	
func animations():
	if get_parent().hitted:
		play("Hit")
	elif $AnimationPlayer.current_animation == "AttackR" or $AnimationPlayer.current_animation == "AttackL":
		pass
	elif get_parent().velocity.x != 0 or get_parent().velocity.y != 0:
		play("Walk")
	else:
		play("Idle")
	pass
	
func get_dmg():
	return dmg
	
func get_bump():
	return bump
	
func delete():
	queue_free()
	pass