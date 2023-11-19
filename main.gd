extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var boid = load("res://boid.tscn")
	for x in range(100):
		var instance = boid.instantiate()
		add_child(instance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
