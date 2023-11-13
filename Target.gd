extends Node2D
var target

func getRandomPoint():
	var screenSize = get_viewport().get_visible_rect().size
	return Vector2(randi() % int(screenSize.x), randi() % int(screenSize.y))

# Called when the node enters the scene tree for the first time.
func _ready():
	target = getRandomPoint()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	draw_circle(target, 10, "#ff0000")
