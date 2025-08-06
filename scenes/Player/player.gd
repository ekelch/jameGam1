extends CharacterBody2D

const SPEED = 250
const JUMP_VEL = -370
const CHARGE_MIN = 50
const CHARGE_MAX = 800
const CHARGE_STEP = 750

var direction_facing = Vector2.RIGHT
var charge = CHARGE_MIN
var has_bucket: bool = true
var charging: bool = false

signal pickup_bucket
signal throw_bucket(pos: Vector2, dir: Vector2, charge: float)

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
		direction_facing = Vector2.RIGHT
	elif x_dir < 0:
		$AnimatedSprite2D.animation = "move_left"
		direction_facing = Vector2.LEFT
	else:
		$AnimatedSprite2D.animation = "idle_right" if direction_facing == Vector2.RIGHT else "idle_left"
	
	# update pos
	position.x += x_dir * delta * SPEED
	move_and_slide()
	
	# other inputs
	if Input.is_action_just_pressed("main_action"):
		if has_bucket:
			charging = true
		else:
			charging = false
			pickup_bucket.emit()
		
	if Input.is_action_pressed("main_action") && charging:
		charge = move_toward(charge, CHARGE_MAX, delta * CHARGE_STEP)
	
	if Input.is_action_just_released("main_action") && charging:
		print("throwing with charge ", charge)
		throw_bucket.emit(global_position, direction_facing, charge)
		charge = CHARGE_MIN
		has_bucket = false
