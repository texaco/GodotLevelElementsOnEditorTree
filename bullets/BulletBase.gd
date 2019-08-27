extends Area2D
class_name BulletBase

export var velocity := 800 setget set_velocity
export var damage := 5
export var direction := Vector2.RIGHT

"""
life_time: Default 0.0
If 0.0 it won't be freed by time
Otherwise bullet will be freed by that time.
"""
export var life_time := 3.0

func _ready():
	_init_visibility_notifier()
	if life_time > 0.0:
		_init_life_timer()
	look_at(global_position + direction)
	
func _init_life_timer():
	$LifeTimer.start(life_time)
	$LifeTimer.connect("timeout", self, "remove")

func _init_visibility_notifier():
	var visibility_notifier : VisibilityNotifier2D = VisibilityNotifier2D.new()
	add_child(visibility_notifier)
	visibility_notifier.connect("screen_exited", self, "remove")

func _move(delta):
	position += direction * velocity * delta
		
func _process(delta):
	_move(delta)
	
func do_harm(target):
	if target.has_method("harm"):
		target.harm(damage)
		remove()
	
func remove():
	queue_free()
	
func set_velocity(vel : int):
	velocity = vel