extends Area2D
class_name EnemyBase

"""
TODO
"""
export var speed := 100.0
export var health := {"max": 10, "damage": 0}
export var damage := 10

"""
delegated_free: Will delegate where the node will be free because exits the screen.
Default false
"""
export var delegated_free := false

var shooter_timer : Timer
var died := false
var collission_normal : Vector2
var direction := Vector2(-1,1)
var effects := Effects.new()

func _ready():
	_init_area()
	_init_visibility_notifier()
	add_child(effects)
		
func _init_visibility_notifier():
	var visibility_notifier : VisibilityNotifier2D = VisibilityNotifier2D.new()
	add_child(visibility_notifier)
	visibility_notifier.connect("screen_exited", self, "on_screen_exit")
	
func _init_area():
	connect("area_entered", self, "on_area_entered")

"""
Return a vector with wall collission normal.
Vector2.ZERO in case that no collission.
Collission will be detected by raycast array
"""
func _get_collission_normal() -> Vector2:
	var collission := Vector2.ZERO 
	if $RayCastDown.is_colliding():
		collission += $RayCastDown.get_collision_normal()
	if $RayCastRight.is_colliding():
		collission += $RayCastRight.get_collision_normal()
	if $RayCastUp.is_colliding():
		collission += $RayCastUp.get_collision_normal()
	if $RayCastLeft.is_colliding():
		collission += $RayCastLeft.get_collision_normal()
		
	return collission.normalized()

func _move(delta):
	if collission_normal != _get_collission_normal():
		collission_normal = _get_collission_normal()
		if collission_normal != Vector2.ZERO:
			direction = direction.bounce(collission_normal)
	position += delta * direction * speed
		
func _process(delta):
	if !died:
		_move(delta)
	
func die():
	died = true
	var timer_to_dead := Timer.new()
	add_child(timer_to_dead)
	$Explosion.emitting = true
	$EnemySprite.visible = false
	timer_to_dead.start(0.5)
	yield(timer_to_dead,"timeout")
	queue_free()

func harm(damage : int):
	effects.blink_color($EnemySprite, Color(1,1,1,1), Color(1,0,0,1), 0.1)
	health.damage += damage
	if health.damage >= health.max: 
		die()

func do_harm(target):
	if target.has_method("harm"):
		target.harm(damage)
		
		Library.logger("Done %s damage to %s" % [damage, target.name])

func on_area_entered(area : Area2D):
	if area.has_method("do_harm"):
		area.do_harm(self)
		
func on_screen_exit():
	if !delegated_free:
		Library.logger("Removing foe")
		queue_free()