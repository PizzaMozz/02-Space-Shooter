extends Node

var VP = Vector2.ZERO

var score = 0
var time = 100
var lives = 5
var level = -1

var levels = [
	
	{
		"Title":"Level 1",
		"asteroids":[Vector2(100,100),Vector2(600,100),Vector2(800,300)],
		"enemies":[Vector2(100,200)],
		"poppas":"",
		"timer":"200",
		"asteroids_spawned":false,
		"enemies_spawned":false,
		"poppas_spawned":false,
	},
	{
		"Title":"Level 2",
		"asteroids":[Vector2(100,100),Vector2(600,100),Vector2(600,300),Vector2(400,200),Vector2(440,0)],
		"enemies":[Vector2(100,200),Vector2(200,300)],
		"poppas":"",
		"timer":"100",
		"asteroids_spawned":false,
		"enemies_spawned":false,
		"poppas_spawned":false,
	},
	{
		"Title":"Level 3",
		"asteroids":[Vector2(100,100),Vector2(600,100),Vector2(600,300),Vector2(400,200),Vector2(440,0)],
		"enemies":[Vector2(100,200),Vector2(200,300)],
		"poppas":[Vector2(200,100)],
		"timer":"50",
		"asteroids_spawned":false,
		"enemies_spawned":false,
		"poppas_spawned":false,
	},
	{
		"Title":"Level 4",
		"asteroids":[Vector2(100,100),Vector2(600,100),Vector2(600,300),Vector2(400,200),Vector2(440,0)],
		"enemies":[Vector2(100,200)],
		"poppas":[Vector2(-100,100),Vector2(200,300)],
		"timer":"25",
		"asteroids_spawned":false,
		"enemies_spawned":false,
		"poppas_spawned":false,
	},
]

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	randomize()
	VP = get_viewport().size
	var _signal = get_tree().get_root().connect("size_changed", self, "_resize")

func _physics_process(_delta):
	var A = get_node_or_null("/root/Game/Asteroid_Container")
	var E = get_node_or_null("/root/Game/Enemy_Container")
	var P = get_node_or_null("/root/Game/BigPoppa_Container")
	if A != null and E != null and P != null:
		var L = levels[level]
		if L["poppas_spawned"] == true and P.get_child_count() == 0 and L["asteroids_spawned"] == true and A.get_child_count() == 0 and L["enemies_spawned"] == true and E.get_child_count() == 0:
			next_level()

func _resize():
	VP = get_viewport().size

func reset():
	get_tree().paused = false
	score = 0
	time = 100
	lives = 5
	level = -1
	for l in levels:
		l["asteroids_spawned"] = false
		l["enemies_spawned"] = false
		l["poppas_spawned"] = false
	
func update_score(s):
	score += s
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_score()
		
func update_lives(l):
	lives += l
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_lives()
	if lives <= 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	
func update_time(t):
	time += t
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_time()
	if time <= 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
		
func next_level():
	level += 1
	if level > levels.size():
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	else:
		var Level_Label = get_node_or_null("/root/Game/UI/Level")
		if Level_Label != null:
			Level_Label.show_labels()
