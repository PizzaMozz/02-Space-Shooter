extends Control


func _ready():
	pass

func _on_PlayButton_pressed():
	var _scene = get_tree().change_scene("res://Game.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
