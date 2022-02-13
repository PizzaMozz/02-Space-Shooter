extends KinematicBody2D

var velocity = Vector2.ZERO
var small_speed = 3.0
var initial_speed = 1.0
var health = 1

onready var Half_1 = load("res://Asteroid/Half_1.tscn")
onready var Half_2 = load("res://Asteroid/Half_2.tscn")
var small_asteroids = [Vector2(30,30),Vector2(-30,30)]

func _ready():
	pass

func _physics_process(_delta):
	var Player = get_node_or_null("/root/Game/Player_Container/Player")
	var d = global_position.angle_to_point(Player.global_position) - PI/2
	
	global_position = global_position + Vector2(0,-initial_speed*randf()).rotated(d)
	rotation = d
	position = position + velocity
	position.x = wrapf(position.x, 0, Global.VP.x)
	position.y = wrapf(position.y, 0, Global.VP.y)


func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(100)
		collision_layer = 0
		var Asteroid_Container = get_node_or_null("/root/Game/Asteroid_Container")
		if Asteroid_Container != null:
			var half1 = Half_1.instance()
			var half2 = Half_2.instance()
			var dir1 = randf()*2*PI
			var i1 = Vector2(0,randf()*small_speed).rotated(dir1)
			var dir2 = randf()*2*PI
			var i2 = Vector2(0,randf()*small_speed).rotated(dir1)
			Asteroid_Container.call_deferred("add_child", half1)
			half1.position = position + small_asteroids[0].rotated(dir1)
			half1.velocity = i1
			Asteroid_Container.call_deferred("add_child", half2)
			half2.position = position + small_asteroids[0].rotated(dir2)
			half2.velocity = i2
		queue_free()
