extends Area2D

var target
signal hit

func reset():
	target = getRandomPoint()
	self.position = target

func getRandomPoint():
	var screenSize = get_viewport().get_visible_rect().size
	return Vector2(randi() % int(screenSize.x), randi() % int(screenSize.y))

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()
	connect("body_entered", self.on_hit)
	
func on_hit():
	print("hit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if randi() % 1000 < 5:
		reset()
	pass

func _draw():
#	draw_circle(Vector2.ZERO, 10, "#ff0000")
	pass
