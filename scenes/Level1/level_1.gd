extends Node2D
@onready var projectiles: Node2D = $Projectiles
var bucket_scene = preload("res://scenes/BucketProjectile/bucket_projectile.tscn")

func _on_player_main_action_pressed(pos: Vector2, dir: Vector2, charge: float) -> void:
	var bucket: RigidBody2D = bucket_scene.instantiate()
	bucket.position = pos + dir * 20
	bucket.linear_velocity = charge * dir
	projectiles.add_child(bucket)
	
