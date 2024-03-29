extends Node2D

onready var Enemy = load("res://Asteroid/Enemy/Enemy.tscn")

func _physics_process(_delta):
	if get_child_count() == 0:
		var level = Global.levels[Global.level]
		if not level["enemies_spawned"]:
			for pos in level["enemies"]:
				var enemy = Enemy.instance()
				enemy.position = pos
				add_child(enemy)
			level["enemies_spawned"] = true
