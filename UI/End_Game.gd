extends Control

func _ready():
	$Label.text = "Thanks for playing! Your final score was " + str(Global.score) + "."

func _on_PlayButton_pressed():
	Global.reset()
	var _scene = get_tree().change_scene("res://Game.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
