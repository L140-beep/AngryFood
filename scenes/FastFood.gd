extends RigidBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var health = 150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.y > 670:
		queue_free()


func _on_FastFood_body_entered(body: Node) -> void:
	if is_instance_valid(body):
		if body is RigidBody2D:
			body = body as RigidBody2D
			if body.is_in_group("Player") and body.linear_velocity > Vector2(1, 1):
				queue_free()
			else:
				var damage = body.linear_velocity.length() * 0.5 
				health -= damage
				if health <= 0:
					queue_free()
