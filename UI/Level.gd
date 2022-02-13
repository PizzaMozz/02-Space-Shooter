extends Control


func show_labels():
	get_tree().paused = true
	$Title.text = Global.levels[Global.level]["Title"]
	show()
	$Timer.start()

func _on_Timer_timeout():
	hide()
	get_tree().paused = false
