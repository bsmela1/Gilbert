extends Actor


func _ready():
	set_physics_process(false)
	_velocity.x = -speed.x


func _physics_process(delta):
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x = -_velocity.x
	_velocity.y = move_and_slide(_velocity,FLOOR_NORMAL).y


func _on_StompDetector_body_entered(body):
	if (body.global_position.y > $StompDetector.global_position.y):
		return
	else:
		$EnemyCollision.set_deferred("enabled", false)
		queue_free()
