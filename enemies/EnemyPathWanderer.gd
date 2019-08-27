extends PathFollow2D

export var lerp_duration := 1.0

func _ready():
	init_movement()
	
func init_movement():
	$Tween.interpolate_property(self, "unit_offset", 0, 1, lerp_duration, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Tween.interpolate_property(self, "unit_offset", 1, 0, lerp_duration, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	init_movement()