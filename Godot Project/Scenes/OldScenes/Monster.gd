extends KinematicBody2D

const speed = 50
const pvMax = 10
const dmg = 1

var target = Vector2()
var velocity = Vector2()
var pv = pvMax
var hitted = false


func _ready():
	$AnimationPlayer.play("Idle")
	pass 


# warning-ignore:unused_argument
func _process(delta):
	target = get_parent().get_node("PlayerClassic").global_position
	velocity = (target - position).normalized() * speed
	if $AnimationPlayer.current_animation=="Recover":
		velocity.x = -velocity.x
		velocity.y = -velocity.y
		velocity = move_and_slide(velocity)
	elif $AnimationPlayer.current_animation != "Hit":
		if (target - position).length() > 5:
        	velocity = move_and_slide(velocity)
			
	if pv<=0:
		die()
		
	animations()
	pass
	
# warning-ignore:unused_argument
func _physics_process(delta):
	collision()
	pass

func animations():
	if $AnimationPlayer.current_animation!="Hit":
		hitted = false
		if velocity.x == 0 and velocity.y == 0 and $AnimationPlayer.current_animation != "Idle" and $AnimationPlayer.current_animation != "Recover":
			$AnimationPlayer.play("Idle")
		elif (velocity.x!=0 or velocity.y != 0) and $AnimationPlayer.current_animation != "Walk" and $AnimationPlayer.current_animation != "Recover":
			$AnimationPlayer.play("Walk")
		if velocity.x<0:
			$Sprite.flip_h =true
		if velocity.x>0:
			$Sprite.flip_h =false
	else:
		hitted = true
	pass
	
func collision():
	var bodies = $AttackHitbox.get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			hitPlayer()
	pass
	
func setPv(newPv):
	pv = newPv
	pass
	
func getPv():
	return pv
	
func hitPlayer():
	if $AnimationPlayer.current_animation != "Recover" and $AnimationPlayer.current_animation != "Hit":
		$Sprite.get_parent().get_parent().get_node("Player").hit(dmg)
		$AnimationPlayer.play("Recover")
	pass
	
func hit(dmg):
	if not hitted:
		hitted = true
		$AnimationPlayer.play("Hit")
		setPv(getPv() - dmg)
	pass
	
func die():
	queue_free()