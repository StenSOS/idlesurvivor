extends Node2D

enum GameState {START, RUNNING, END}

@onready var timer_label = $HUD/timerLabel

@export var winTime :float

var elapsedTime := 0.0

func _process(delta):
	elapsedTime += delta
	
	var minutes = int(elapsedTime)/60
	var seconds = int(elapsedTime)%60
	
	timer_label.text =  "%02d:%02d" % [minutes, seconds]
	
	if elapsedTime >= winTime:
		print("win")
