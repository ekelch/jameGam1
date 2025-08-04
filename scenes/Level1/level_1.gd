extends Node2D
@onready var projectiles: Node2D = $Projectiles
var bucket_scene = preload("res://scenes/BucketProjectile/bucket_projectile.tscn")
const MIN_ANGLE = 30
const MAX_ANGLE = 60
const CHARGE_MIN = 100
const CHARGE_MAX = 500

func _on_player_main_action_pressed(pos: Vector2, dir: Vector2, charge: float) -> void:
	var bucket: RigidBody2D = bucket_scene.instantiate()
	bucket.position = pos
	bucket.linear_velocity = Vector2.from_angle(MIN_ANGLE + (MAX_ANGLE - MIN_ANGLE) * (charge / (CHARGE_MAX - CHARGE_MIN))) * charge * dir.x
	projectiles.add_child(bucket)
	print("throwing bucket")
	
