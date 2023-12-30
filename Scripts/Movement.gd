extends CharacterBody2D


var speed = 64
var direction = Vector2.ZERO
var HP: float
var stamina: float
var stam_regen_timer: float

# 0 -- idle, 1 -- walk, 2 -- sprint
var state = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_disabled = false
var sound_complete = true
var attack_finished = true
var attack_disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	HP = 100
	stamina = 100
	$AttackTrail.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if not is_disabled:
		move()
	if not attack_disabled:
		attack()
	else:
		$Sprite2D/AnimationTree.set("parameters/Idle/blend_position", direction)
		$Sprite2D/AnimationTree.get("parameters/playback").travel("Idle")

func move():
	var vert = Input.get_axis("ui_up","ui_down")
	var horiz = Input.get_axis("ui_left","ui_right")
	velocity = Vector2(horiz,vert)
	
	if velocity != Vector2.ZERO:
		direction = velocity.normalized()
		if !Input.is_action_pressed("sprint") || stamina <= 0:
			state = 1
	else:
		state = 0
	velocity = velocity.normalized() * speed
	if Input.is_action_pressed("sprint") && get_real_velocity() != Vector2.ZERO && stamina > 0:
		stamina -= get_physics_process_delta_time() * 20
		stam_regen_timer = 0
		velocity *= 1.75
		state = 2
		

	move_and_slide()
	animate()

	# stamina regeneration code
	if stamina <= 100:
		stam_regen_timer += get_process_delta_time() * 2
	if stam_regen_timer >= 2:
		if stamina < 100:
			stamina += get_process_delta_time() * 10

func animate():
	# var state_machine = $Sprite2D/AnimationTree.get("parameters/playback")
	var anim_direction
	
	# until animtree stops being shit this will have to do
	if direction.angle() >= -PI/4 - 0.001 && direction.angle() <= PI/4 + 0.001:
		anim_direction = "right"
	elif direction.angle() > PI / 4 && direction.angle() < 3 * PI/4:
		anim_direction = "front"
	elif direction.angle() >= 3 * PI / 4 || direction.angle() <= -3 * PI / 4:
		anim_direction = "left"
	elif direction.angle() > 5 * PI / 4 || direction.angle() < -PI/4 - 0.001:
		anim_direction = "back"

	if state == 0 || is_disabled:
		$Sprite2D/AnimationPlayer.play(anim_direction + "_idle")
		$Particles.emitting = false
	elif state == 1:
		$Sprite2D/AnimationPlayer.play(anim_direction + "_walk")
		$Particles.emitting = false
		
		# dont fucking know why but this line must be here
		#$Sprite2D/AnimationPlayer.play("right_walk")
	else:
		$Sprite2D/AnimationPlayer.play(anim_direction + "_run")
		$Particles.direction = Vector2(0, -98)
		$Particles.emitting = true

func attack():
	# get the mouse position
	var mouse = get_viewport().get_mouse_position() + self.position - get_viewport_rect().get_center()
	var mouse_direction = (mouse - self.position).normalized()
	
	if attack_finished:
		$AttackTrail.rotation = mouse_direction.angle() + PI / 24
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and attack_finished and stamina >= 10:
		attack_finished = false
		$AttackTrail.visible = true
		$AttackTrail/AnimationPlayer.play("attack_trail")
		stam_regen_timer = 0
		stamina -= 10
		await($AttackTrail/AnimationPlayer.animation_finished)
		$AttackTrail/AnimationPlayer.stop()
		$AttackTrail.visible = false
		await(get_tree().create_timer(0.5).timeout)
		attack_finished = true


		

#func play_sound():
#	sound_complete = false
#	$AudioStreamPlayer2D.play()
#	yield(get_tree().create_timer(0.5),"timeout")
#	sound_complete = true
