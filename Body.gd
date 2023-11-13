extends RigidBody2D
@export var speed = 300
@export var angular_speed = PI
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	draw_line(Vector2.ZERO, Vector2(0,-200),"#ff0000", 5)
	
func getRotationDirection(a, b, c):
	var dot = (b.x - a.x)*(c.y - a.y) - (b.y - a.y)*(c.x - a.x);
	if dot < 0:
		return -1
	elif dot > 0:
		return +1
	else:
		return 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.UP.rotated(self.rotation) * speed
	position += velocity * delta
	var target = $"../Target".position
	var direction = getRotationDirection(position, position + Vector2.UP.rotated(self.rotation) * 200, target)
	self.rotation += angular_speed * delta * direction
