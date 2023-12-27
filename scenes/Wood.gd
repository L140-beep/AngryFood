extends RigidBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var health = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Wood_body_entered(body: Node) -> void:
	if is_instance_valid(body):
		if body is RigidBody2D:
			body = body as RigidBody2D
			var damage = body.linear_velocity.length() * 0.009
			health -= damage
			if (health <= 0):
				queue_free()
