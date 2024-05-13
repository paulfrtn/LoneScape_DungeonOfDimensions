extends CanvasLayer




func _on_button_pressed():
	get_tree().change_scene_to_file("res://Lvl_1/Scenes/main.tscn")

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Menu/Credit.tscn")


func _on_button_3_pressed():
	get_tree().quit()

