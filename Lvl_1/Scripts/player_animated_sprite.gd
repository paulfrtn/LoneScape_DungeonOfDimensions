extends AnimatedSprite2D

class_name PlayerAnimatedSprite

var frame_count = 0
func trigger_animation(velocity: Vector2, direction: int, player_mode: Player.PlayerMode):
	var animation_prefix = Player.PlayerMode.keys()[player_mode].to_snake_case()
	
	if not get_parent().is_on_floor():
		play("%s_jump" % animation_prefix)
		if direction != 0:
			scale.x = direction*2
	
	#handle slide animations
	elif direction != 0:
		scale.x = direction*2
		if velocity.x != 0:
			play("%s_run" % animation_prefix)
		else:
			play("%s_idle" % animation_prefix)
	else :
	# handle the sprite direction
		if scale.x == 1 && sign(velocity.x) == -1:
			scale.x = -1
		elif scale.x == -1 && sign(velocity.x) == 1:
			scale.x = 1
		
		# handle run and idle animations
		if velocity.x != 0:
			play("%s_run" % animation_prefix)
		else:
			play("%s_idle" % animation_prefix)
		

func _on_animation_finished():
	if animation == "grey_to_dark":
		reset_player_properties()
		match get_parent().player_mode:
			Player.PlayerMode.dark:
				get_parent().player_mode = Player.PlayerMode.grey
			Player.PlayerMode.grey:
				get_parent().player_mode = Player.PlayerMode.dark
	if animation == "grey_to_gold" || animation == "dark_to_gold":
		reset_player_properties()
		get_parent().player_mode = Player.PlayerMode.gold
	
	if animation == "shoot":
		get_parent().set_physics_process(true)

func reset_player_properties():
	offset = Vector2.ZERO
	get_parent().set_physics_process(true)
	get_parent().set_collision_layer_value(1, true)
	frame_count = 0

func _on_frame_changed():
	if animation == "grey_to_dark" || animation == "grey_to_gold":
		var player_mode = get_parent().player_mode
		frame_count += 1
		
		if frame_count % 2 == 1:
			offset = Vector2(0, 0 if player_mode == Player.PlayerMode.dark else - 8)
		else:
			offset = Vector2(0, 8 if player_mode == Player.PlayerMode.dark else 0)

func on_pole(player_mode: Player.PlayerMode):
	var animation_prefix = Player.PlayerMode.keys()[player_mode].to_snake_case()
	play("%s_pole" % animation_prefix)	
