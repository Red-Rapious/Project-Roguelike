extends Node2D

export var number = 0
#export var size = Vector2(0,0)

export var dtop=false
export var dleft=false
export var ddown=false
export var dright=false

var in_fight = false
var room_clear=false

func _ready():
	rooms_list.ddown[number]=ddown
	rooms_list.dtop[number]=dtop
	rooms_list.dleft[number]=dleft
	rooms_list.dright[number]=dright
	pass

# warning-ignore:unused_argument
func _process(delta):
	if in_fight and $Monsters.get_children()==[] and $Spawners.get_children()==[]:
		end_fight()
		pass
	pass

func new_path(start):
	return $Navigation2D.get_simple_path(start, global.position)
	
func start_fight():
	if not in_fight and not room_clear:
		in_fight=true
		for door in $Doors.get_children():
			door.close()
		for monster in $Monsters.get_children():
			monster.set_agro(true)
		for spawner in $Spawners.get_children():
			if spawner.has_method("launch_wave"):
				spawner.launch_wave()
	pass
	
func end_fight():
	if in_fight:
		in_fight=false
		for door in $Doors.get_children():
			door.open()
		room_clear=true
	pass