extends BulletBase

export var max_aiming := 100
export var aiming_rate := 0.25

var target_ref : WeakRef
var aiming_count := 0

func _ready():
	if life_time == 0.0:
		life_time = 3
	target_ref = weakref(Library.get_space_ship())
	_init_aiming_timer()
	_aim()

func _init_aiming_timer():
	$AimingTimer.connect("timeout", self, "_on_aiming")
	$AimingTimer.start(aiming_rate)
	
func _move(delta):
	if target_ref.get_ref():
		._move(delta)
	else:
		queue_free()

func _aim():
	if target_ref.get_ref():
		var target = target_ref.get_ref()
		direction = (target.global_position - global_position).normalized()
		look_at(target.global_position)

func _on_aiming():
	if aiming_count < max_aiming:
		aiming_count += 1
		_aim()