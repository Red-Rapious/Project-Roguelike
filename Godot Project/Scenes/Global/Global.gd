extends Node

var player
var current
var playing=""

var players

var sound_instance = preload("res://Scenes/SoundPlayers/SoundInstance.tscn")
var instance

var sound_library = ["Monsters/deathd.wav","Monsters/deathb.wav","Monsters/deathe.wav"]

func _ready():
	choose_music()
	pass
	
func _process(delta):
	choose_music()
	
	if Input.is_action_just_pressed("ui_accept"):
		if get_tree().paused==true:
			get_tree().paused=false
		else:
			get_tree().paused=true
	pass
	
func choose_music():
	
	current = get_tree().current_scene.get_name()
	match current:
		"TitleScreen", "LoadingScreen", "PlayerSelectScreen":
			playing="Theme"
		"Map1-1":
			playing="InGame"
		_:
			playing=""
	stop_all()
	if playing != "":
		play(playing)
	pass
	

	
func play(music):
	
	player=get_node(music)
	if not player.playing:
		player.play()
	pass
	
func play_sound(sound):
	player=get_node(sound)
	if not player.playing:
		player.play()
	pass

func stop_all():
	players = get_tree().get_nodes_in_group("music")
	for node in players:
		if node.name != playing :
			node.stop()
	pass
	
func play_sound_instance(sound,volume):
	instance = sound_instance.instance()
	instance.play_stream(str("res://Assets/Sound/Effects/"+sound_library[sound]), volume)
	add_child(instance)
	pass