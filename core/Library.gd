extends Node

const DEBUG: bool = false

func logger(log_message : String):
	if DEBUG:
		print(log_message)
		
func get_space_ship() -> Area2D:
	return get_tree().get_nodes_in_group("space_ship")[0]

func get_enemies_spawn() -> Node2D:
	return get_tree().get_nodes_in_group("enemy")[0]
	
func get_bullet_spawn() -> Node2D:
	return get_tree().get_nodes_in_group("bullet")[0]
	
func get_instance(node : Node):
	var instance_node
	if node.filename == null or node.filename == "":
		return
		
	instance_node = load(node.filename).instance()
	
	for property in node.get_property_list():
		if _is_assignable_property(property):
			instance_node.set(property.name, node.get(property.name))
	
#	for child in node.get_children():
#		var child_instance = get_instance(child)
#		if child_instance != null:
#			instance_node.add_child(child_instance)
			
	return instance_node
	
func _is_assignable_property(property):
	return _is_script_variable(property) or _is_collision_configuration(property)
	
func _is_script_variable(property):
	return property.usage & PROPERTY_USAGE_SCRIPT_VARIABLE == PROPERTY_USAGE_SCRIPT_VARIABLE
	
func _is_collision_configuration(property):
	return property.name == "collision_layer" or property.name == "collision_mask"