extends EnemyBase

var target_ref : WeakRef

func _ready():
	target_ref = weakref(Library.get_space_ship())	
	
func _move(delta):
	if target_ref.get_ref():
		var target : Area2D = target_ref.get_ref()
		look_at(target.global_position)