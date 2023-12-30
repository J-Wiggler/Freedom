extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/StartButton.grab_focus()
	$AnimationPlayer.play("menu_load")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_quit_button_mouse_entered():
	$CanvasLayer/QuitButton.modulate = Color(0.75, 0.75, 0.75, 1)
	pass # Replace with function body.


func _on_start_button_mouse_entered():
	$CanvasLayer/StartButton.modulate = Color(0.75, 0.75, 0.75, 1)
	pass # Replace with function body.


func _on_start_button_mouse_exited():
	$CanvasLayer/StartButton.modulate = Color(1, 1, 1, 1)
	pass # Replace with function body.


func _on_quit_button_mouse_exited():
	$CanvasLayer/QuitButton.modulate = Color(1, 1, 1, 1)
	pass # Replace with function body.
