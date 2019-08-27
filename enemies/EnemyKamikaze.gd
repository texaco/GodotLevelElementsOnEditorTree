extends EnemyBase

var target_ref : WeakRef

func _ready():
	target_ref = weakref(Library.get_space_ship())
	
func _move(delta):
	if target_ref.get_ref():
		var target = target_ref.get_ref()
		direction = (target.global_position - global_position).normalized()
		._move(delta)
	else:
		position += Vector2.LEFT * speed * delta