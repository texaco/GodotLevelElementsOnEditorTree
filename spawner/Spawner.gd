extends Position2D

export var max_enemies := 5

var count := 0
var enemy : EnemyBase
var enemy_spawn : Node2D

func _ready():
	enemy_spawn = Library.get_enemies_spawn()
	for child in get_children():
		if child is EnemyBase:
			enemy = Library.get_instance(child)
			enemy.global_position = global_position
			remove_child(child)

func _on_spawn():
	if count < max_enemies:
		count += 1
		var new_enemy = Library.get_instance(enemy)
		new_enemy.global_position = global_position
		enemy_spawn.add_child(new_enemy)
	else:
		$SpawnTimer.queue_free()

func _on_screen_entered():
	$SpawnTimer.start()