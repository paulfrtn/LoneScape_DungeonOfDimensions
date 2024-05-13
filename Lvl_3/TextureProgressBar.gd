extends TextureProgressBar

@export var boss : Boss

func _ready():
	boss.health_changed.connect(update)
	update()

func update():
	value = boss.health_point
