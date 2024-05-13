extends Node2D

func _ready():
	var timer = $Timer



func _on_timer_timeout():
	get_tree().quit()
