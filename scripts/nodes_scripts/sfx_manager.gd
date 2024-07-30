extends Node

signal sfx_play(path: String)
@onready var audioPlayers: Array[Node] = get_children()

func _ready():
	connect("sfx_play", _on_sfx_play)
	
func _on_sfx_play(path: String):
	var audioAssigned: bool = false
	var index: int = 0
	while (index < audioPlayers.size() && !audioAssigned):
		var currentPlayer: AudioStreamPlayer = audioPlayers[index] as AudioStreamPlayer
		if (currentPlayer.stream == null):
			currentPlayer.stream = load(path)
			currentPlayer.play()
			audioAssigned = true
		index += 1

