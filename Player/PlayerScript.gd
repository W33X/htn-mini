extends CharacterBody2D

#Movement related variables
var movementVector = Vector2(0, 0)
var speed = 3
var arm_tween
var health = 100

#Gun interactions
var projectile = preload("res://Player/Projectiles/ProjectileBase.tscn")
func fire():
	var bullet = projectile.instantiate(PackedScene.GEN_EDIT_STATE_MAIN)
	bullet.position = $Arm/ArmExit.global_position
	bullet.rotation = $Arm/ArmExit.global_rotation
	get_parent().add_child(bullet)

# Overall movement
func get_movement():
	if Input.is_action_pressed("Move_Down"):
		movementVector.y += speed
	if Input.is_action_pressed("Move_Up"):
		movementVector.y -= speed
	if Input.is_action_pressed("Move_Right"):
		movementVector.x += speed
	if Input.is_action_pressed("Move_Left"):
		movementVector.x -= speed
	if Input.is_action_just_pressed("Fire"):
			fire()

func handle_animation():
	if movementVector != Vector2(0, 0):
		$PlayerSprite.animation = "he_walk"
	else:
		$PlayerSprite.animation = "he_idle"

# Main loop
@warning_ignore("unused_parameter")
func _physics_process(_delta):
	get_movement()
	handle_animation()
	arm_tween = get_tree().create_tween()
	print(movementVector)
	arm_tween.tween_property($Arm, "rotation", $Arm.rotation + $Arm.get_angle_to(get_global_mouse_position()), 0.1)
	move_and_collide(movementVector)
	movementVector = Vector2(0, 0)
