extends Node
class_name Effects

var tween := Tween.new()

func _ready():
	add_child(tween)
	
func blink_color(node : Object, color_ini: Color, color_end: Color, time: float):
	tween.interpolate_property(
		node, 
		"modulate", 
		color_ini, 
		color_end, 
		time, 
		Tween.TRANS_BOUNCE, 
		Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_all_completed")
	tween.interpolate_property(
		node, 
		"modulate", 
		color_end, 
		color_ini, 
		time, 
		Tween.TRANS_BOUNCE, 
		Tween.EASE_IN_OUT)
	tween.start()
