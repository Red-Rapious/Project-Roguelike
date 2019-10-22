extends Node2D

export var side = false
export var right_side = false

func _ready():
	if side:
		$Side.set_visible(true)
		$Classical.set_visible(false)
		if right_side:
			$Side.flip_h=true
	pass
