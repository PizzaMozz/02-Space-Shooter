extends Node2D

onready var BigPoppa = load("res://Asteroid/BigPoppa/BigPoppa.tscn")

func _physics_process(_delta):
	if get_child_count() == 0:
		var level = Global.levels[Global.level]
		if not level["poppas_spawned"]:
			for pos in level["poppas"]:
				var poppa = BigPoppa.instance()
				poppa.position = pos
				add_child(poppa)
			level["poppas_spawned"] = true
