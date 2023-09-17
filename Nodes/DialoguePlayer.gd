extends Control

signal proceed
var initialized
@export var player: Node

func _input(event):
	if event.is_action_pressed("ui_accept"):
		emit_signal("proceed")
# Called when the node enters the scene tree for the first time.
func _ready():
	initialize("res://test.json")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func initialize(d_path: String):
	if !initialized:
		var f = FileAccess.open(d_path, FileAccess.READ)
		var json = JSON.new()
		var text = f.get_as_text()
		json.parse(text)
		var dialogue = json.data
		player.is_disabled = true
		parse_d(dialogue)
	
func parse_d(dialogue: Array):
	for i in range(len(dialogue)):
		var name_d = dialogue[i]["Name"]
		var line = dialogue[i]["Text"]
		$TextureRect/Name.text = name_d
		$TextureRect/Dialogue.text = line
		$TextureRect/Dialogue.visible_characters = 0
		for c in len(line):
			$TextureRect/Dialogue.visible_characters += 1
			if (line[c] == ',' or line[c] == '?' or line[c] == '!'):
				await(get_tree().create_timer(0.05).timeout)
			if (line[c] == '.'):
				await(get_tree().create_timer(0.25).timeout)
			else:
				await(get_tree().create_timer(0.02).timeout)
		await(proceed)
	self.visible = false
	player.is_disabled = false
	
