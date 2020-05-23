extends KinematicBody2D

export (int) var detect_radius
export (float) var fire_rate
export (PackedScene) onready var Bullet

var vis_color = Color(.867, .91, .247, 0.1)

signal do_maina

var target
var can_shoot = true


func _ready():
	$Sprite.self_modulate = Color(0.5, 0, 0)
	var shape = CircleShape2D.new()
	shape.radius = detect_radius
	$Visibility/CollisionShape2D.shape = shape
	$ShootTimer.wait_time = fire_rate
	target = null

func _physics_process(delta):
	update()
	if target:
		rotation = (target.position - position).angle()
		if can_shoot:
			shoot(target.position)


func aim():
	var space_state = get_world_2d().direct_space_state


func shoot(pos):
	var b = Bullet.instance()
	var a = (pos - global_position).angle()
	b.start(global_position, a - 0.01)
	get_parent().add_child(b)
	can_shoot = false
	$ShootTimer.start()
	b.connect("hitted", self, "hitteeed") #Polaczenie sygnalu z bullet.tscn do wiezy


func _draw():
	draw_circle(Vector2(), detect_radius, vis_color)


func _on_Visibility_body_entered(body):
	if target:
		return
	if body.collision_layer==1:
		target = body
		$Sprite.self_modulate.r = 5.0


func _on_Visibility_body_exited(body):	
	if body == target:
		target = null
		$Sprite.self_modulate.r = 0.2


func _on_ShootTimer_timeout():
	can_shoot = true


func hitteeed():
	emit_signal("do_maina")
