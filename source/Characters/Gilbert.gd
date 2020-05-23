extends Actor

export var stomp_impulse: = 2000.0
signal hitted_by_mob


func _on_EnemyDetector_area_entered(area: Area2D):
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)


func _on_EnemyDetector_body_entered(body):
	#get_tree().create_timer(300000, true)
	#emit_signal("hitted_by_mob")
	queue_free()
	
	
func _physics_process(delta):
	var direction = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	move_and_slide(_velocity, FLOOR_NORMAL)
	animate_gilbert(_velocity)


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right")-Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor()==true else 1.0
	)


func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y	
	return new_velocity


func animate_gilbert(velocity_to_anim: Vector2):
	if(is_on_floor()==false):
		if(velocity_to_anim.y < 0.0 and velocity_to_anim.x > 0.0):
			$GilbertSprite.flip_h = false
			$GilbertSprite.play("Rising")
		elif(velocity_to_anim.y < 0.0 and velocity_to_anim.x < 0.0):
			$GilbertSprite.flip_h = true
			$GilbertSprite.play("Rising")
		else:
			$GilbertSprite.play("Falling")	
	elif(velocity_to_anim.x > 0.0):
		$GilbertSprite.flip_h = false
		$GilbertSprite.play("Running")
	elif(velocity_to_anim.x < 0.0):
		$GilbertSprite.flip_h = true
		$GilbertSprite.play("Running")
	else:
		$GilbertSprite.play("Idle")


func calculate_stomp_velocity(
	linear_velocity: Vector2,
	impulse: float
) -> Vector2:
	var new_velocity = linear_velocity
	new_velocity.y = -impulse
	return new_velocity
