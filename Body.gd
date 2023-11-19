extends RigidBody2D
@export var maxspeed = 1000
@export var minspeed = 200
@export var angular_speed = PI
@export var avoidFactor = 0.5
@export var matchFactor = 0.5
@export var centeringFactor = 0.05
@export var turnFactor = 10
var target
var avoidList = []
var alignList = []
	
# Called when the node enters the scene tree for the first time.
func _ready():
	target = getRandomPoint()
	self.position = Vector2(randi()%600 + 200,randi()%600 + 200)
	self.linear_velocity = Vector2(randi()%200, randi()%200)
	pass # Replace with function body.

func getRandomPoint():
	var screenSize = get_viewport().get_visible_rect().size
	return Vector2(randi() % int(screenSize.x), randi() % int(screenSize.y))

func _draw():
#	draw_line(Vector2.ZERO, Vector2(0,-200),"#ff0000", 5)
	pass
	
func getRotationDirection(a, b, c):
	var dot = (b.x - a.x)*(c.y - a.y) - (b.y - a.y)*(c.x - a.x);
	if dot < 0:
		return -1
	elif dot > 0:
		return +1
	else:
		return 0
	
func checkHit():
	if abs(position-target) < Vector2(5,5):
		target = getRandomPoint()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	# Seperation
	var close = Vector2(0,0)
	for boid in avoidList:
		close += self.position - boid.position
	self.linear_velocity += close * avoidFactor
	
	# Alignment
	var avgVelocity = Vector2(0,0)
	for boid in alignList:
		if boid not in avoidList:
			avgVelocity += boid.linear_velocity
	avgVelocity /= len(alignList)
	self.linear_velocity += (avgVelocity - self.linear_velocity) * matchFactor

	# Cohesion
	var avgPosition = Vector2(0,0)
	for boid in alignList:
		if boid not in avoidList:
			avgPosition += boid.position
	avgPosition /= len(alignList)
	self.linear_velocity += (avgPosition - self.position) * centeringFactor
	$AnimatedSprite2D.rotation = self.linear_velocity.angle() + PI/2

	#Clamp velocity
	var velocity = linear_velocity.length()
	if velocity < minspeed:
		linear_velocity = linear_velocity/velocity * minspeed
	if velocity > maxspeed:
		linear_velocity = linear_velocity/velocity * maxspeed
		
	# Edge os screen
	if position.x < 200:
		self.linear_velocity.x += turnFactor
	if position.x > get_viewport().size.x - 200:
		self.linear_velocity.x -= turnFactor
	if position.y < 200:
		self.linear_velocity.y += turnFactor
	if position.y > get_viewport().size.y - 200:
		self.linear_velocity.y -= turnFactor
	
func _on_area_2d_body_entered(body):
	if body != self:
		avoidList.append(body)

func _on_area_2d_body_exited(body):
	if body != self:
		avoidList.erase(body)


func alignEnter(body):
	if body != self:
		alignList.append(body)


func alignExit(body):
	if body != self:
		alignList.erase(body)
