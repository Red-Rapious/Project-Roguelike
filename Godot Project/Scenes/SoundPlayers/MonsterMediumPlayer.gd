extends Node

var random

func _on_MediumClassic_attack():
	random = randf()
	if random <= 0.5:
		$Attack1.play()
	else:
		$Attack2.play()

func _on_MediumClassic_hit():
	$HitMedium.play()
	pass 
