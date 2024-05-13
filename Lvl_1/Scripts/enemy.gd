extends Area2D

class_name Enemy

const POINTS_LABEL_SCENE = preload("res://Lvl_1/Scenes/points_label.tscn")

@export var horizontal_speed = 20
@export var vertical_speed = 100

@onready var ray_cast_2d = $RayCast2D as RayCast2D
@onready var animated_sprite_2d = $AnimatedSprite2D as AnimatedSprite2D

func _ready():
	set_process(false)

func _process(delta):
	position.x -= delta * horizontal_speed
	
	if !ray_cast_2d.is_colliding():
		position.y += delta * vertical_speed
		

func die():
	horizontal_speed = 0
	vertical_speed = 0
	animated_sprite_2d.play("dead")
	
func die_from_hit():
	set_collision_layer_value(3, false)
	set_collision_mask_value(3, false)
	
	vertical_speed = 0
	horizontal_speed = 0
	animated_sprite_2d.play("dead")
	
	var die_tween = get_tree().create_tween()
	get_tree().create_timer(1.5).timeout.connect(queue_free)
	
	var points_label = POINTS_LABEL_SCENE.instantiate()
	points_label.position = self.position + Vector2(-20, - 20)
	get_tree().root.add_child(points_label)
	var level_manager = get_tree().get_first_node_in_group("level_manager")
	level_manager.on_points_scored(100)
	
	
func _on_area_entered(area):
		die_from_hit()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	

func _on_body_entered(body):
	if body.is_in_group("wall"):
		horizontal_speed *= -1


func _on_visible_on_screen_notifier_2d_screen_entered():
	set_process(true)

