
class_name Bullet extends AnimatableBody3D

signal collided(collision: KinematicCollision3D)

@export var lifetime : float = 1.0
@export var damage : int = 10

var lifetime_timer : Timer

var velocity : Vector3
var speed : float :
	get: return velocity.length()
	set(value): velocity = velocity.normalized() * value


func _init() -> void:
	collided.connect(_on_collided)

	lifetime_timer = Timer.new()
	lifetime_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	lifetime_timer.wait_time = lifetime
	lifetime_timer.autostart = true
	lifetime_timer.timeout.connect(queue_free)
	add_child(lifetime_timer)


func _populate(source: PhysicsBody3D = null) -> void:
	if source == null: return

	add_collision_exception_with(source)


func _physics_process(delta: float) -> void:
	if not visible: return

	var collision := move_and_collide(velocity * delta)
	if collision == null: return

	collided.emit(collision)


func _on_collided(collision: KinematicCollision3D) -> void:
	for i in collision.get_collision_count():
		velocity = velocity.bounce(collision.get_normal(i))


