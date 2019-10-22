extends Node2D


var p_scene = load("res://Scenes/Characters/Players/"+global.player_type+".tscn")
var p_instance
var player
export var start_position = Vector2(0,0)

var r_scene
var r_instance

var room_map# = [[1,0],[4,3]]

func _ready():
	global.set_room_time(OS.get_unix_time())
	instance_player()
	set_room_map()
	build_room_map()
	get_tree().call_group("torch", "set_visible", options.use_light)
	$CanvasModulate.set_visible(options.use_light)
	pass 

func build_room_map():
	for x in range(room_map.size()):
		for y in range(room_map[x].size()):
			if not room_map[x][y]==0:
				r_scene=load("res://Scenes/Rooms/AllRooms/Room"+str(room_map[x][y])+".tscn")
				r_instance = r_scene.instance()
				r_instance.position=calculate_position(y,x)
				$RoomsContainer.call_deferred("add_child",r_instance)
				
	pass

func _on_Popup_about_to_show():
	$HUD/Control.visible=false
	pass 


func _on_Popup_popup_hide():
	$HUD/Control.visible=true
	pass

func instance_player():
	p_instance = p_scene.instance()
	add_child(p_instance)
	player = p_instance
	player.position = start_position
	pass
	
func calculate_position(x,y):
	var cx
	var cy
	#x
	cx=x*320
	"""if y>0:
		if not room_map[x-1][y]==0:
			if rooms_list.ddown[room_map[x-1][y]]:
				cx=cx+rooms_list.cdown[room_map[x-1][y]]-rooms_list.ctop[room_map[x][y]]
	"""
	#y
	cy=y*320
	"""if x>0:
		if not room_map[x][y-1]==0:
			if rooms_list.dright[room_map[x][y-1]]:

				cy=cy+rooms_list.cright[room_map[x][y-1]]-rooms_list.cleft[room_map[x][y]]
	"""
	return Vector2(cx,cy)
	
func set_room_map():
	room_map=levels.levels[global.world-1][global.level-1]