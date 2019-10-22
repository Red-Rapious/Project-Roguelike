extends Control

func _ready():
	#$All/Central/Skull/AnimatedSprite.play("idle")
	
	for button in $All/Central/Buttons.get_children():
		button.connect("pressed", button, "_on_Button_pressed")
	pass

func _process(delta):
	pass
