extends AudioStreamPlayer

var sample

func play_stream(sound, volume):
	sample = load(sound)
	set_stream(sample)
	set_volume_db(volume)
	play()
	pass
	
	
func _on_SoundInstance_finished():
	queue_free()
	pass 
