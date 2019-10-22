extends "res://Scenes/Characters/Character.gd"

signal hpChanged(newHp)

signal attack()
signal critical()
signal armor_broken()
signal armor_recover()
signal switch_weapon()
signal get_new_weapon()


export var acceleration = 25


var scene
var weapon_node
var instance


func _ready():
	
	scene  = load("res://Scenes/Weapons/"+global.weapon1+".tscn")
	instance = scene.instance()
	add_child(instance)
	weapon_node = instance
	setPv(global.pv)
	change_weapon(global.weapon1)
	$Critical.visible = false
	$CollisionShape2D.get_shape().set_height(0.52) 
	$CollisionShape2D.get_shape().set_radius(9)
	global.position=global_position
	global.reset_hp()
	pvMax = global.pv_max
	pv = global.pv
	pass

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		if velocity.x > -global.maxVel:
			velocity.x -= acceleration
	elif Input.is_action_pressed("ui_right"):
		if velocity.x < global.maxVel:
			velocity.x += acceleration
	else:
		velocity.x =0
		
	if Input.is_action_pressed("ui_up"):
		if velocity.y > -global.maxVel:
			velocity.y -= acceleration
	elif Input.is_action_pressed("ui_down"):
		if velocity.y < global.maxVel:
			velocity.y += acceleration
	else:
		velocity.y = 0
		
	if Input.is_action_just_pressed("ui_hit"):
		attack()
	dmg = weapon_node.get_dmg()
	attackBump = weapon_node.get_bump()
	
	if Input.is_action_just_pressed("switch_weapon"):
		switch_weapon()
	
	if $ArmorRecover.time_left == 0 and  get_armor()!=global.armor_max:
		if get_armor()==0:
			emit_signal("armor_recover")
		set_armor(global.armor_max)
	
	global.position=position
	
	#print zone

	pass
	
func animations():
	if $AnimationPlayer.current_animation != "Recover":
		if hitted:
			play("Hit")
			pass
		elif velocity.x == 0 and velocity.y == 0:
			play("Idle")
			pass
		else:
			play("Walk")
			pass
	
	if velocity.x<0:
		$Sprite.flip_h =true
		dir = 1
	if velocity.x>0:
		$Sprite.flip_h =false
		dir = 0
	pass
	
	
func die_check():
	if global.pv<=0 and not died:
		die()
		died=true

	
func attack():
	weapon_node.attack()
	pass
	
func hitMonster(monster):
	if monster.has_method("hit"):
		if rand_range(1,11) <= global.critic_chances:
			monster.hit(dmg*2, attackBump*2)
			$CriticalPlayer.play("Critical")
			emit_signal("critical")
		else:
			monster.hit(dmg, attackBump)
			emit_signal("attack")
	pass
	
func die():
	Global.play_sound("Dead")
	# warning-ignore:return_value_discarded
	get_tree().change_scene("Scenes/UI/Menus/DeathMenu.tscn")
	pass
	
func getPv():
	return global.pv
	
func remove_pv(nbr):
	$ArmorRecover.start()
	if get_armor() <= 0:
		setPv(getPv()-nbr)
	else:
		if get_armor() > nbr:
			set_armor(get_armor()-nbr)
		else:
			emit_signal("armor_broken")
			set_armor(0)
	pass
	
func setPv(new):
	global.lost_hp+=global.pv-new
	pv=new
	global.pv = new
	
	emit_signal("hpChanged", new)
	pass
	
func set_armor(new):
	global.armor = new
	pass
	
func get_armor():
	return global.armor
	
func change_weapon(var wname):
	if wname != " ":
		scene  = load("res://Scenes/Weapons/"+wname+".tscn")
		weapon_node.delete()
		instance = scene.instance()
		add_child(instance)
		weapon_node = instance
		
	pass
	
#func get_weapon() -> String:
#	return weapon

func _on_Stairs_scene_changed(old_weapon):
	change_weapon(old_weapon)
	pass
	
func switch_weapon():
	if global.actual_weapon_is_first:
		use_weapon(false)
	else:
		use_weapon(true)
	emit_signal("switch_weapon")
	pass
	
func use_weapon(first):
	if first:
		if global.weapon1 != " ":
			change_weapon(global.weapon1)
			global.actual_weapon_is_first=true
	else:
		if global.weapon2 != " ":
			change_weapon(global.weapon2)
			global.actual_weapon_is_first=false
	pass

func set_actual_weapon(weapon_name):
	if global.actual_weapon_is_first and global.weapon2 !=" ":
		global.weapon1=weapon_name
		change_weapon(global.weapon1)
	elif not global.actual_weapon_is_first and global.weapon1 !=" ":
		global.weapon2=weapon_name
		change_weapon(global.weapon2)
	elif global.weapon1 ==" ":
		global.weapon1=weapon_name
	else:
		global.weapon2=weapon_name
	emit_signal("get_new_weapon")
	pass
