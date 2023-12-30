extends Area2D

var active:bool
@export var target: String
@export var coords: Vector2
var map: Node
var tgt_map: Node
var world: Node
var player: Node
# Called when the node enters the scene tree for the first time.
func _ready():
	map = get_node("..")
	player = get_node("../../Sage")
	world = get_node("../..")
	tgt_map = load("res://Maps/" + target).instantiate()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if active:
			player.is_disabled = true
			var anim = world.get_node("CanvasLayer/Transition/AnimationPlayer")
			anim.play("change_level")
			await(get_tree().create_timer(0.4).timeout)
			world.add_child(tgt_map)
			player.position = coords
			world.remove_child(map)
			player.is_disabled = false
			
func _on_body_entered(body):
	if body.is_in_group("player"):
		active = true
	pass # Replace with function body.
func _on_body_exited(body):
	if body.is_in_group("player"):
		active = false
	pass # Replace with function body.
