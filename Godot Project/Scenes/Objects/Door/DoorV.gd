extends "res://Scenes/Objects/Door/DoorClassic.gd"

func _ready():
	pass

func set_collision_shapes():
	$InteractArea/CollisionShape2D.get_shape().set_extents(Vector2(16,4))
	$InteractArea/CollisionShape2D.position = Vector2(-12,0)
	$InteractArea2/CollisionShape2D.get_shape().set_extents(Vector2(16,4))
	$InteractArea2/CollisionShape2D.position = Vector2(12,0)
	
	$InteractArea/CollisionShape2D.rotation_degrees=90
	$InteractArea2/CollisionShape2D.rotation_degrees=90
	pass