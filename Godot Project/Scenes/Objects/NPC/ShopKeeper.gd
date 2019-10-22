extends "res://Scenes/Objects/ObjectClassic.gd"



func _ready():
	$Label.visible=false
	$ThankYou.visible=false
	
func _process(delta):
	$Label.visible=false
	pass
	
func on_player_collapse():
	if $ThankYou.visible==false:
		$Label.visible=true
	pass
	
func on_collapse(body):
	$Label.set_visible(false)
	if body.is_in_group("player"):
		$Label.set_visible(true)
	pass
	
func start_thanks():
	$ThankYou.visible=true
	$Label.visible=false
	$Scam.visible=false
	$Timer.start()
	pass

func start_scam():
	$ThankYou.visible=false
	$Label.visible=false
	$Scam.visible=true
	$Timer.start()
	pass

func _on_Timer_timeout():
	$ThankYou.visible=false
	$Scam.visible=false
