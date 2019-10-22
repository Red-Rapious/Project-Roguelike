extends Node

var random

func _on_PlayerClassic_armor_broken():
	$BrokenArmor.play()
	pass

func _on_PlayerClassic_armor_recover():
	$RecoverArmor.play()
	pass 

func _on_PlayerClassic_get_new_weapon():
	$NewWeapon.play()
	pass 

func _on_PlayerClassic_switch_weapon():
	$SwitchWeapon.play()
	pass 
	

func _on_PlayerClassic_attack():
	random = randf()
	if random <= 0.33:
		$Attack1.play()
	elif random <= 0.66:
		$Attack2.play()
	else:
		$Attack3.play()
	pass 

func _on_PlayerClassic_critical():
	$Critical.play()
	pass 
