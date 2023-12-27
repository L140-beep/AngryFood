extends Node2D

enum State {
	idle,
	pull,
	throw,
	reset
}
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var animate = false
var state = State.idle 
onready var left_line: Line2D = $LeftLine
onready var right_line: Line2D = $RightLine
onready var line_2d: Line2D = $Line2D
onready var vegetable_pos: Position2D = $VegetablePos
var center
var player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center = vegetable_pos.global_position
	var player = get_tree().get_nodes_in_group("Player")[0]
	player.global_position = center

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _physics_process(delta: float) -> void:
	match state:
		State.idle:
			pass
		State.pull:
			var player = get_tree().get_nodes_in_group("Player")[0] as RigidBody2D
			var camera = get_tree().get_nodes_in_group("Camera")[0]
			camera.player = player 
			if Input.is_action_pressed("LeftMouse"):
				var mouse = get_global_mouse_position()
				if mouse.distance_to(center) > 100:
					mouse = (mouse - center).normalized() * 100
				# $ColorRect2.rect_position = $LeftPos.position + mouse
				# $ColorRect2.rect_size = mouse * 2
				# var rdiff = (mouse - $ColorRect.rect_position).length()
				# var ldiff = (mouse - $ColorRect2.rect_position).length()
				# $ColorRect.rect_scale = Vector2(1, rdiff)
				# $ColorRect2.rect_scale = Vector2(1, ldiff)
				left_line.points[1] = mouse.normalized() * 100
				right_line.points[1] = mouse.normalized() * 100
			else:
				var location = get_global_mouse_position()
				var distance = location.distance_to(center)
				var velocity = center - location
				player.throwBird() 
				player.apply_impulse(Vector2(), velocity/50 * distance)
				state = State.throw
				left_line.points[1] = center
				right_line.points[1] = center
				GameManager.current_game_state = GameManager.State.Playing
				camera.followingPlayer = true
				camera.player = player
				#get_tree().get_nodes_in_group("Camera")[0].followingPlayer = true
		State.throw:
			pass
		State.reset:
			var birds = get_tree().get_nodes_in_group("Player")
			if birds.size() > 0:
				player = get_tree().get_nodes_in_group("Player")[0] as RigidBody2D
				if not animate:
					player = get_tree().get_nodes_in_group("Player")[0] as RigidBody2D
					$Tween.interpolate_property(player, "global_position", player.global_position, center, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
					$Tween.start()
					animate = true
				elif (player.global_position - center).length() < 4:
					state = State.idle
					print('sdasdasd')
					animate = false
func _on_TouchArea_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if state == State.idle:
		if event is InputEventMouseButton and event.pressed:
			print('here')
			state = State.pull
