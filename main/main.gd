extends Node2D

enum GameState {START, RUNNING, END}

@onready var timer_label = $HUD/Panel/timerLabel
@onready var money_label = $HUD/Panel2/moneyLabel
@onready var diamond_label = $HUD/Panel3/diamondLabel

@onready var player = $Player

@export var winTime :float
@export var money : int = 0
@export var diamonds : int = 0

var elapsedTime := 0.0

func _ready():
	update_ui()

func _process(delta):
	if not player.isDead:
		elapsedTime += delta
	
	var minutes = int(elapsedTime)/60
	var seconds = int(elapsedTime)%60
	
	timer_label.text =  "%02d:%02d" % [minutes, seconds]
	
	if elapsedTime >= winTime:
		print("win")

func add_currency(amount: int, is_diamond: bool = false):
	if is_diamond:
		diamonds += amount
	else:
		money += amount
	update_ui()

func update_ui():
	money_label.text = str(money)
	diamond_label.text =  str(diamonds)
