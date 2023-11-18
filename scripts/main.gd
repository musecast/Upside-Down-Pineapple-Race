extends Node2D



func _ready():
	#$dino.connect("spike_collision", self, "_on_player_spike_collision")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play(Music.musicProgress) 
	pass


func _on_cake_body_entered(body):
	if Music.gameOn == 1:
		Music.gameOn = 0
		Music.winTime = "" +str(int($HUD/Timer.time_left))+""
		$HUD/Timer.stop()
		$HUD/WINtext.show()
		$HUD/Button.show()
		$HUD/timeLeft.text = Music.winTime
		
		if Music.deathCount == 1:
			$HUD/attempts.text = "in "+ str(Music.deathCount) +" attempt"
		else:
			$HUD/attempts.text = "in "+ str(Music.deathCount) +" attempts"
		
		$HUD/attempts.show()
	
	

func _on_spikes_body_entered(body):
	if body.name == "dino":
		var audio = get_node("/root/Node2D/AudioStreamPlayer")
		#Music.musicProgress = get_tree().get_playback_position(AudioStreamPlayer)
		Music.musicProgress = audio.get_playback_position() 
		get_tree().reload_current_scene()
		Music.deathCount = Music.deathCount + 1
		Music.gameOn = 1
		
		
