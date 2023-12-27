extends Camera2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var startingPos = global_position
onready var player = get_tree().get_nodes_in_group("Player")[0]
var followingPlayer = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

func _process(delta: float) -> void:
	if followingPlayer:
		if is_instance_valid(player):
			if player.global_position.x > global_position.x:
				var player_pos = clamp(player.position.x, 0, 1000)
				global_position = Vector2(player_pos, startingPos.y)
		else:
			followingPlayer = false
			$Tween.interpolate_property(self, "position", position, startingPos, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
