extends Control


@onready var player = get_node("../../Sage")
var menu_open: bool
var alert_val: float

# Called when the node enters the scene tree for the first time.
func _ready():
	$Inventory.visible = false
	$Stamina.modulate.a = 0
	$HP.modulate.a = 0
	$AlertStatus.modulate = 0

	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("menu"):
		$AnimationPlayer.play("open_playerui")
		$Inventory/AnimationPlayer.play("inventory_open")
	if Input.is_action_just_released("menu"):
		menu_open = false
		$AnimationPlayer.play("close_playerui")
		$Inventory/AnimationPlayer.play("inventory_close")
		await($AnimationPlayer.animation_finished)
		$Inventory.visible = false
	if Input.is_action_pressed("menu"):
		menu_open = true
		$Inventory.visible = true
		$Stamina.modulate.a = 1
	if Input.is_action_pressed("ui_accept"):
		if alert_val <= 100:
			alert_val += 2
			await(get_tree().create_timer(get_process_delta_time()).timeout)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	display_alert()
	if !menu_open:
		if $Stamina.value < 100:
			if $Stamina.modulate.a <= 1.0:
				$Stamina.modulate.a += 2 * get_physics_process_delta_time()
		else:
			if $Stamina.modulate.a >= 0:
				$Stamina.modulate.a -= 2 * get_physics_process_delta_time()
	$Stamina.value = player.stamina
	$AlertArrow/TextureProgressBar.value = alert_val
	pass
	
func display_alert():
	var mouse = get_viewport().get_mouse_position() + player.position - get_viewport_rect().get_center()
	var offset = 364
	var direction = (mouse - player.position).normalized()
	var arrow_pos = offset * direction + Vector2(960, 540)
	$AlertArrow.rotation = direction.angle() + PI/2
	$AlertArrow.position = arrow_pos
	if alert_val >= 100:
		$AlertArrow.modulate.g = 0
		$AlertArrow.modulate.b = 0
	elif alert_val >= 50:
		$AlertArrow.modulate.r = 1
		$AlertArrow.modulate.g = 0.5
		$AlertArrow.modulate.b = 0.5
	else:
		$AlertArrow.modulate.r = 1
		$AlertArrow.modulate.g = 1
		$AlertArrow.modulate.b = 1
	if alert_val >= 0:
		alert_val -= 0.5
