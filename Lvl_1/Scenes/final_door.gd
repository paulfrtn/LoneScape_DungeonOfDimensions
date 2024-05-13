extends Area2D

func _ready():
	pass

func _process(delta):
	pass



func _on_body_entered(body):
	if body is Player:
		get_tree().change_scene_to_file("res://Lvl_3/Level_3.tscn")
