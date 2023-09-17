extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/StartButton.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_focus_entered():
	$CanvasLayer/StartButton/RichTextLabel.text = "[center][>>START<<]"
	$CanvasLayer/StartButton.grab_focus()


func _on_start_button_focus_exited():
	$CanvasLayer/StartButton/RichTextLabel.text = "[center][--START--]"
	$CanvasLayer/StartButton.release_focus()


func _on_quit_button_focus_entered():
	$CanvasLayer/QuitButton/RichTextLabel.text = "[center][>>QUIT<<]"
	$CanvasLayer/QuitButton.grab_focus()
	pass # Replace with function body.


func _on_quit_button_focus_exited():
	$CanvasLayer/QuitButton/RichTextLabel.text = "[center][--QUIT--]"
	$CanvasLayer/QuitButton.release_focus()
	pass # Replace with function body.
