extends PathFollow2D

export var speed := 200.0

func _process(delta):
	
	offset += delta * speed
