extends CharacterBody2D


var speed = 64
var direction = Vector2.ZERO

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_disabled = false
var sound_complete = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if not is_disabled:
		move()
#	else:
#		$AnimationTree.set("parameters/Idle/blend_position", direction)
#		$AnimationTree.get("parameters/playback").travel("Idle")

func move():
	var vert = Input.get_axis("ui_up","ui_down")
	var horiz = Input.get_axis("ui_left","ui_right")
	velocity = Vector2(horiz,vert)
	
	if velocity != Vector2.ZERO:
		direction = velocity.normalized()
#	animate()
#	if sound_complete && velocity != Vector2.ZERO:
#		play_sound()
	velocity = velocity.normalized()*speed
	if Input.is_action_pressed("sprint"):
		velocity *= 1.75
	move_and_slide()
	
#func animate():
#	if velocity == Vector2.ZERO:
#		$AnimationTree.set("parameters/Idle/blend_position", direction)
#		$AnimationTree.get("parameters/playback").travel("Idle")
#	else:
#		$AnimationTree.set("parameters/Walk/blend_position", direction)
#		$AnimationTree.get("parameters/playback").travel("Walk")

#func play_sound():
#	sound_complete = false
#	$AudioStreamPlayer2D.play()
#	yield(get_tree().create_timer(0.5),"timeout")
#	sound_complete = true
