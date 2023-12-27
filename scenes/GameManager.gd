extends Node2D

enum State {
	Start,
	Playing,
	Win,
	Lose
}
var current_game_state = State.Start

func _ready():
	pass
	
func _process(delta):
	match current_game_state:
		State.Start:
			pass
		State.Playing:
			var birds = get_tree().get_nodes_in_group("Birds")
			var pigs = get_tree().get_nodes_in_group("FastFood")
			
			if pigs.size() <= 0:
				current_game_state = State.Win
			elif birds.size() <= 0:
				current_game_state = State.Lose
		State.Win:
			pass
			#print("You won")
		State.Lose:
			pass
			#print("You lose")

