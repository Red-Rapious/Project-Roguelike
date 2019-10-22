extends "res://Scenes/Characters/Character.gd"

export var speed = 50

var target = Vector2(0,0)
var path
var start_point

var agro = false

export var min_gold = 2
export var max_gold = 4

signal attack()

func _ready():
	pvMax = 3
	pv = pvMax
	pass

# warning-ignore:unused_argument
func _process(delta):
	#target = get_parent().get_parent().get_parent().get_node(global.player_type).global_position
	target = global.position
	#path_to_velocity()
	velocity = (target - global_position).normalized() * speed
	if (target.x-global_position.x > 180 or target.y-global_position.y > 180 or target.x-global_position.x < -180 or target.y-global_position.y < -180) or not agro:
		velocity = Vector2(0,0)
	
	if $AnimationPlayer.current_animation=="Recover":
		velocity.x = -velocity.x
		velocity.y = -velocity.y
	pass
	
# warning-ignore:unused_argument
func _physics_process(delta):
	collision()
	pass
	
func collision():
	var bodies = $AttackHitbox.get_overlapping_bodies()
	for body in bodies:
		if body.name == global.player_type:
			hitPlayer()
	pass
	
func hitPlayer():
	if $AnimationPlayer.current_animation != "Recover" and not hitted:
		emit_signal("attack")
		#get_parent().get_parent().get_node(global.player_type).hit(dmg, attackBump)
		get_tree().call_group("player","hit", dmg, attackBump)
		play("Recover")
	pass
	
func die():
	global.add_gold(int(rand_range(min_gold,max_gold)))
	global.monster_killed+=1
	dead_sound()
	queue_free()
	pass
	
func animations():
	if $AnimationPlayer.current_animation != "Recover":
		if hitted:
			play("Hit2")
		elif velocity.x == 0 and velocity.y == 0:
			pass
			play("Idle")
		else:
			pass
			play("Walk")
	if velocity.x<0:
		$Sprite.flip_h =true
		dir = 1
	if velocity.x>0:
		$Sprite.flip_h =false
		dir = 0
	pass
	
func set_path(npath):
	path=npath
	pass
	
func path_to_velocity():
	path = get_parent().get_parent().new_path(position)
	if path.size() > 2:
		target = path[1]
	pass
	
func dead_sound():
	Global.play_sound_instance(1,-10)
	pass
	
func set_agro(new_agro):
	agro=new_agro
	pass
	
func hit(dmg, bump):
	if not hitted:
		hitted = true
		remove_pv(dmg)
		play("Hit2")
		actBump = bump
		emit_signal("hit")
	pass
	
func hit_check():
	if $AnimationPlayer.current_animation != "Hit2":
		hitted = false
	pass