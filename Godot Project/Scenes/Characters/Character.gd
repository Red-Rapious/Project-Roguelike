extends KinematicBody2D

export var pvMax = 10
# warning-ignore:unused_class_variable
var attackBump = 0

signal hit()

var velocity = Vector2()
var pv = pvMax
var hitted = false
# warning-ignore:unused_class_variable
export var dmg = 1
var dir = 0 #0=r 1=l
# warning-ignore:unused_class_variable
var bodies
var actBump = 0
var died = false

func _ready():
	$AnimationPlayer.play("Idle")
	pass

# warning-ignore:unused_argument
func _process(delta):
	hit_check()
	animations()
	if pv>pvMax:
		setPv(pvMax)
	die_check()
	pass
	
func hit_check():
	if $AnimationPlayer.current_animation != "Hit":
		hitted = false
	pass
	
func die_check():
	if pv <= 0 and not died:
		die()
		died=true
	pass
# warning-ignore:unused_argument
func _physics_process(delta):
	if not hitted:
		# warning-ignore:return_value_discarded
		move_and_slide(velocity)
	else:
		# warning-ignore:return_value_discarded
		move_and_slide(-velocity*actBump*0.5)
	pass

func animations():
	"""if $AnimationPlayer.current_animation != "Recover":
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
		dir = 0"""
	pass

func attack():
	pass

func setPv(newPv):
	pv = newPv
	
func getPv():
	return pv
	
func hit(dmg, bump):
	if not hitted:
		hitted = true
		remove_pv(dmg)
		play("Hit")
		actBump = bump
		emit_signal("hit")
	pass
	
func remove_pv(nbr):
	setPv(getPv()-nbr)
	pass
	
func die():
	pass
	
func play(anim):
	if $AnimationPlayer.current_animation != anim:
		$AnimationPlayer.play(anim)
		pass
	pass
	
func getDir():
	return dir