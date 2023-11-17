extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$WINtext.hide()
	$Button.hide()
	$attempts.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Music.gameOn == 1:
		$timeLeft.text = str(int($Timer.time_left))
	else:
		$timeLeft.text = str(Music.winTime)


#func update_score(score):


func _on_timer_timeout():
	var audio = get_node("/root/Node2D/AudioStreamPlayer")
	#Music.musicProgress = get_tree().get_playback_position(AudioStreamPlayer)
	Music.musicProgress = audio.get_playback_position() 
	get_tree().reload_current_scene()


func _on_button_pressed():
	var audio = get_node("/root/Node2D/AudioStreamPlayer")
	#Music.musicProgress = get_tree().get_playback_position(AudioStreamPlayer)
	Music.musicProgress = audio.get_playback_position() 
	get_tree().reload_current_scene()
	Music.deathCount = 1
	Music.gameOn = 1
	
