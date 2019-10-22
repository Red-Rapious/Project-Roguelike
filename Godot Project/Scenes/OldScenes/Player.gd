extends KinematicBody2D



const acceleration = 25
const maxVel = 150
const pvMax = 10

var velocity = Vector2()
var pv = pvMax
var hitted = false
var dmg = 1
var dir = 0 #0=r 1=l
var bodies

func _ready():
	$AnimationPlayer.play("Idle")
	$AnimationPlayerWeapon.play("Idle")
	$Weapon.position = Vector2(16,45)
	$Weapon.rotation_degrees = 45
	pass

func _process(delta):
	
	if Input.is_action_pressed("ui_left"):
		if velocity.x > -maxVel:
			velocity.x -= acceleration
	elif Input.is_action_pressed("ui_right"):
		if velocity.x < maxVel:
			velocity.x += acceleration
	else:
		velocity.x =0
		
	if Input.is_action_pressed("ui_up"):
		if velocity.y > -maxVel:
			velocity.y -= acceleration
	elif Input.is_action_pressed("ui_down"):
		if velocity.y < maxVel:	
			velocity.y += acceleration
	else:
		velocity.y = 0
		
	if Input.is_action_just_pressed("ui_hit"):
		attack()
	
	animations()
	pass

func _physics_process(delta):
	if pv <= 0:
		die()
	if not hitted:
		move_and_slide(velocity)
	pass

func animations():
	if $AnimationPlayer.current_animation!="Hit":
		if velocity.x == 0 and velocity.y == 0 and $AnimationPlayer.current_animation != "Idle":
			$AnimationPlayerWeapon.play("Idle")
		if (velocity.x!=0 or velocity.y != 0) and $AnimationPlayer.current_animation != "Walk":
			$AnimationPlayerWeapon.play("Walk")
	if velocity.x<0:
		$Sprite.flip_h =true
		#$Weapon.flip_h=true
		$Weapon.rotation_degrees=315
		$Weapon.position.x = 0
		dir = 1
	if velocity.x>0:
		$Sprite.flip_h =false
		#$Weapon.flip_h=false
		$Weapon.rotation_degrees=45
		$Weapon.position.x = 16
		dir = 0
	pass

func attack():
	match dir:
		0:
			bodies = $RightColl.get_overlapping_bodies()
			$AnimationPlayerWeapon.play("AttackR")
			for body in bodies:
				if body.name == "Monster":
					hitMonster(body)
		1:
			bodies = $LeftColl.get_overlapping_bodies()
			$AnimationPlayerWeapon.play("AttackL")
			for body in bodies:
				if body.name == "Monster":
					hitMonster(body)
	pass
	
func hitMonster(id):
	if id.has_method("hit"):
		id.hit(dmg)
	pass

func setPv(newPv):
	pv = newPv
	pass
	
func getPv():
	return pv
	
func hit(dmg):
	if not hitted:
		hitted = true
		$AnimationPlayer.play("Hit")
		$AnimationPlayerWeapon.play("Hit")
		setPv(getPv() - dmg)
	pass
	
func die():
	get_tree().change_scene("Scenes/DeathMenu.tscn")
	pass