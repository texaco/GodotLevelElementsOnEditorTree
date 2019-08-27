extends Node2D

export var fire_rate := 0.5

var bullet : BulletBase
var bullet_spawn : Node2D
var timer_start = false

func _ready():
		
	$FireTimer.wait_time = fire_rate
	bullet_spawn = Library.get_bullet_spawn()
		
	for child in get_children():
		if child is BulletBase:
			bullet = Library.get_instance(child)
			remove_child(child)

func _process(delta):
	if timer_start and $FireTimer.is_stopped():
		$FireTimer.start()

func _on_fire():
	var new_bullet = Library.get_instance(bullet)
	new_bullet.global_position = global_position
	bullet_spawn.add_child(new_bullet)
