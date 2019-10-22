extends Node

var random

func _on_BabyClassic_attack():
	random = randf()
	if random <= 0.5:
		$Attack1.play()
	else:
		$Attack2.play()
	pass 

func _on_BabyClassic_hit():
	$HitBaby.play()
