extends Node2D

@export var player : Player
@onready var label = $Camera2D/Label

var life_point_player = 0

func _ready():
	player.life_point_changed.connect(update)
	update()

func _process(delta):
	label.text = "Life : " + str(life_point_player)

func update():
	life_point_player = player.life_point
