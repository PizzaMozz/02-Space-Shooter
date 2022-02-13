extends KinematicBody2D

var velocity = Vector2.ZERO
var small_speed = 3.0
var initial_speed = 1.0
var health = 1

onready var Zomb = load("res://Asteroid/Asteroid.tscn")
var zombs = [Vector2(30,30),Vector2(-30,30),Vector2(-50,20)]

func _ready():
	velocity = Vector2(0,initial_speed*randf()).rotated(PI*2*randf())

func _physics_process(_delta):
	var Player = get_node_or_null("/root/Game/Player_Container/Player")
	var d = global_position.angle_to_point(Player.global_position) - PI/2
	rotation = d
	position = position + velocity
	position.x = wrapf(position.x, 0, Global.VP.x)
	position.y = wrapf(position.y, 0, Global.VP.y)


func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(100)
		collision_layer = 0
		var BigPoppa_Container = get_node_or_null("/root/Game/BigPoppa_Container")
		if BigPoppa_Container != null:
			for z in zombs:
				var zomb = Zomb.instance()
				var dir1 = randf()*2*PI
				var i1 = Vector2(0,randf()*small_speed).rotated(dir1)
				BigPoppa_Container.call_deferred("add_child", zomb)
				zomb.position = position + zombs[0].rotated(dir1)
				zomb.velocity = i1
			
		queue_free()
