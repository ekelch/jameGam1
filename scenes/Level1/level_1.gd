extends Node2D
@onready var bucketC: Node2D = $BucketContainer
@onready var player: CharacterBody2D = $Player
var bucket_scene = preload("res://scenes/BucketProjectile/bucket_projectile.tscn")
	
func _on_player_pickup_bucket() -> void:
	var bucketP: Vector2 = bucketC.get_child(0).position
	var distance = bucketP.distance_to(player.position)
	if distance < 50:
		print('picking up')
		bucketC.get_child(0).queue_free()
		player.has_bucket = true

func _on_player_throw_bucket(pos: Vector2, dir: Vector2, charge: float) -> void:
	var bucket: RigidBody2D = bucket_scene.instantiate()
	bucket.position = pos + dir * 20
	bucket.linear_velocity = charge * dir
	bucketC.add_child(bucket)
