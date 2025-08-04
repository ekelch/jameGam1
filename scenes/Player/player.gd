extends CharacterBody2D

const SPEED = 250
const JUMP_VEL = -370
var last_right:bool = true
const CHARGE_MIN = 100
const CHARGE_MAX = 500
var charge = CHARGE_MIN

signal mainActionPressed(pos: Vector2, charge: float)

func _physics_process(delta: float) -> void:
	# gravity and jumping
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VEL
	if !is_on_floor():
		velocity.y += get_gravity().y * delta
	
	# update animation
	var x_dir = Input.get_axis("left", "right")
	if x_dir > 0:
		$AnimatedSprite2D.animation = "move_right"
		last_right = true
	elif x_dir < 0:
		$AnimatedSprite2D.animation = "move_left"
		last_right = false
	else:
		$AnimatedSprite2D.animation = "idle_right" if last_right else "idle_left"
	
	# update pos
	position.x += x_dir * delta * SPEED
	move_and_slide()
	
	# other inputs
	if Input.is_action_pressed("main_action"):
		charge = move_toward(charge, CHARGE_MAX, delta * 500)
	elif Input.is_action_just_released("main_action"):
		mainActionPressed.emit(global_position, charge)
		charge = CHARGE_MIN
