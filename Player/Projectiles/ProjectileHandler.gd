extends CharacterBody2D

# Basic init so I can use one script for more bullet types
var damage = 1

func _physics_process(delta):
	move_and_collide(Vector2(6, 0).rotated(rotation))

# This is fucking bullshit who the fuck thought it would be a good idea to force the type and return completion wtf

func wall_hit():
	#TODO: Add wall types (NOTE: Why?)
	queue_free()

func Body_Entered(body: Node2D) -> void:
	if !body.is_in_group("Player") and body != self:
		#body.hit(damage) Currently no such function
		wall_hit()
