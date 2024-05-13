extends Area2D
class_name Boss


@export var player : Player

@onready var animated_sprite_2d = $AnimatedSprite2D

signal health_changed

var is_attacking = false
var damaged=false
var is_dead = false
var health_point = 300
var player_pos_x = 0

func _ready():
	player.pos_x_changed.connect(update)
	update()


func _physics_process(delta):
	if is_attacking and is_dead:
		is_attacking=false
		animated_sprite_2d.animation = "death"
	if not is_attacking and not is_dead:
		animated_sprite_2d.animation = "Idle"
	if abs(player_pos_x - position.x )<=600 and abs(player_pos_x - position.x )>300  and not is_dead:
		is_attacking=true
		animated_sprite_2d.animation = "attaque"
	else:
		is_attacking=false
	if health_point==0:
		is_dead = true
		animated_sprite_2d.animation = "death"
	if damaged:
		health_point-=10
		get_damage()
	if abs(player_pos_x - position.x )>=700 and sign(player_pos_x - position.x)>0:
		position.x +=5
	elif abs(player_pos_x - position.x )>=700 and sign(player_pos_x - position.x)<0:
		position.x -=5
	if sign(player_pos_x - position.x)>0:
		animated_sprite_2d.flip_h= true
	else:
		animated_sprite_2d.flip_h= false

func _on_animated_sprite_2d_animation_looped():
	if(is_dead):
		queue_free()
		get_tree().change_scene_to_file("res://Lvl_3/Win.tscn")
	if animated_sprite_2d.animation == "attaque":
		player.life_point-=1
	is_dead = false
	
	
func get_damage():
	health_point-=10
	health_changed.emit()
	
func update():
	player_pos_x = player.position.x


func _on_area_entered(area):
	get_damage()

