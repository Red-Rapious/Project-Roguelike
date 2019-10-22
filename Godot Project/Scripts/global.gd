extends Node

var pv 
var pv_max
var armor_max
var weapon1
var weapon2
var player_type
var critic_chances #3=30%
var level
var world
var nextLevel
var armor
var gold

var maxVel
var actual_weapon_is_first = true
var position = Vector2(0,0)

const show_loading_screen=true

var room_start_time=0
var old_gold = 0
var monster_killed=0
var lost_hp=0

func _ready():
#	base.start()
	reset()
	pass

#COLORS used :
# dark2 : 27 15 20
#- dark : 35 20 26
#- medium : 58 38 58
#- light : 105 75 73

#-light/light : 132 130 130

func reset():
#	base.start()
	player_type = "Knight"
	pv_max= base.max_hp[player_type]
	pv=pv_max
	armor_max=5
	armor=armor_max
	gold=0
	weapon1="Knife"
	weapon2=" "
	critic_chances=3
	level=1
	world=1
	#nextLevel="1-2"
	maxVel = 150
	pass
	
func reset_hp():
	pv_max= base.max_hp[player_type]
	if pv>pv_max:
		pv=pv_max
	pass
	
func next_level():
	old_gold=gold
	lost_hp=0
	monster_killed=0
	level+=1
	pass
	
func add_gold(x):
	gold+=x
	
func set_room_time(time):
	room_start_time=time
	pass
	
func set_time():
	var min0
	var sec0
	if (OS.get_unix_time()-global.room_start_time)/60<10:
		min0="0"
	else:
		min0=""
	if (OS.get_unix_time()-global.room_start_time)%60<10:
		sec0="0"
	else:
		sec0=""
	return min0+str((OS.get_unix_time()-global.room_start_time)/60)+":"+sec0+str((OS.get_unix_time()-global.room_start_time)%60)
	