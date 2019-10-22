extends CanvasLayer

var min0 = ""
var sec0=""

func _on_PlayerClassic_hpChanged(newhp):
	$Label.text = "HP: " + str(newhp)
	pass
	
func _ready():
	pass
	
func _process(delta):
	$Control/VBoxContainer/Top/Time.text=global.set_time()
	$Control/VBoxContainer/Top/Bars/PV.text = "HP: "+str(global.pv)
	$Control/VBoxContainer/Top/Bars/Armor.text = "AR: "+str(global.armor)
	$Control/VBoxContainer/Top/Golds/Gold.text = "Gold: "+str(global.gold)
	$Control/VBoxContainer/Down/Level.text = str(global.world)+"-"+str(global.level)
	if global.actual_weapon_is_first:
		$Control/VBoxContainer/Down/WeaponsNames/Weapon1.text = global.weapon1
		$Control/VBoxContainer/Down/WeaponsNames/Weapon2.text = global.weapon2
	else:
		$Control/VBoxContainer/Down/WeaponsNames/Weapon1.text = global.weapon2
		$Control/VBoxContainer/Down/WeaponsNames/Weapon2.text = global.weapon1
	pass
	
"""func set_time():
	if (OS.get_unix_time()-global.room_start_time)/60<10:
		min0="0"
	else:
		min0=""
	if (OS.get_unix_time()-global.room_start_time)%60<10:
		sec0="0"
	else:
		sec0=""
	$Control/VBoxContainer/Top/Time.text= min0+str((OS.get_unix_time()-global.room_start_time)/60)+":"+sec0+str((OS.get_unix_time()-global.room_start_time)%60)
	pass"""