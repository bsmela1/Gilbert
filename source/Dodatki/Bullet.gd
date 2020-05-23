extends Area2D

export var speed = 200
var velocity = Vector2()

signal hitted

func start(pos, direction):
	position = pos
	rotation = direction
	velocity = Vector2(speed, 0).rotated(direction)


func _physics_process(delta):
	position += velocity * delta


func _on_Bullet_body_entered(body):
	if body.get_name() == "Gilbert":
		emit_signal("hitted")
		queue_free()
	else:
		queue_free()
