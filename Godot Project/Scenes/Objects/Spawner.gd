extends Node2D

export var wave_list = [["Devil","BabyDevil","Devil"]]
var scene
var instance
var launching = false

signal start_launching_wave()
signal end_wave()
signal all_waves_launched()

func _ready():
	$Sprite.set_visible(false)
	launch_wave()
	pass
	
	
func launch_wave():
	if not launching:
		launching=true
		$Sprite.set_visible(true)
		emit_signal("start_launching_wave")
		$AnimationPlayer.play("Launch")
		$Timer.start()
		if wave_list==[]:
			emit_signal("all_waves_launched")
	pass

func create_monster():
	scene = load(str(monsters_list.prefix+monsters_list.list[wave_list[0][0]]+monsters_list.end))
	instance = scene.instance()
	instance.position=position
	instance.set_agro(true)
	get_parent().get_parent().get_node("Monsters").call_deferred("add_child",instance)
	wave_list[0].remove(0)
	if wave_list[0]==[]:
		end_wave()
	else:
		$AnimationPlayer.play("Launch")
		$Timer.start()
	
	if wave_list==[[]]:
		emit_signal("all_waves_launched")
	pass

func _on_Timer_timeout():
	create_monster()
	pass 

func _on_Spawner_all_waves_launched():
	queue_free()
	
func end_wave():
	launching=false
	emit_signal("end_wave")
	$Sprite.set_visible(false)
	pass
	
func set_wave_list(new_list):
	wave_list=new_list
	pass
	
func add_wave(new_wave):
	wave_list.insert(wave_list.size(),new_wave)
	pass