extends Camera2D


@export var player : Player
@onready var label = $Label

var life_point_player = 0

func _ready():
	player.life_point_changed.connect(update)
	update()

func _process(delta):
	label.text = "Ma variable : " + str(player.life_point)

func update():
	life_point_player = player.life_point
