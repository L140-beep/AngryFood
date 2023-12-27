class_name Vegetable extends RigidBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

enum State {
	notThrown,
	thrown
}

var state = State.notThrown
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mode = RigidBody2D.MODE_KINEMATIC

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.y > 670:
		var slingshot = get_tree().get_nodes_in_group("Slingshot")[0]
		slingshot.state = slingshot.State.reset
		queue_free()
	if state == State.thrown && linear_velocity <= Vector2(.5, .5):
		var t = Timer.new()
		t.set_wait_time(7)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		var slingshot = get_tree().get_nodes_in_group("Slingshot")[0]
		slingshot.state = slingshot.State.reset
		queue_free()

func throwBird():
	mode = RigidBody2D.MODE_RIGID
	state = State.thrown


func _on_VisibilityNotifier2D_screen_exited() -> void:
	pass
	#var slingshot = get_tree().get_nodes_in_group("Slingshot")[0]
	#slingshot.state = slingshot.State.reset
	#queue_free()


func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
	pass # Replace with function body.
