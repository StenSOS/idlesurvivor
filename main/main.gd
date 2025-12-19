extends Node2D

enum GameState {START, RUNNING, END}

@onready var timer_label = $HUD/Panel/timerLabel
@onready var money_label = $HUD/Panel2/moneyLabel
@onready var diamond_label = $HUD/Panel3/diamondLabel

@onready var player = $Player

@export var winTime :float
@export var money : int 
@export var diamonds : int 

var elapsedTime := 0.0

func _ready():
	money = GameData.totalMoney
	diamonds = GameData.totalDiamonds
	update_ui()

func _process(delta):
	if not player.isDead:
		elapsedTime += delta
	
	var minutes = int(elapsedTime)/60
	var seconds = int(elapsedTime)%60
	
	timer_label.text =  "%02d:%02d" % [minutes, seconds]
	
	if elapsedTime >= winTime:
		print("win")

func addMoney():
	GameData.totalMoney += GameData.moneyPerEnemy
	update_ui()

func update_ui():
	money_label.text = str(GameData.totalMoney)
	diamond_label.text =  str(GameData.totalDiamonds)


func _on_return_menu_button_pressed():
	get_tree().change_scene_to_file("res://mainMenu/main_menu.tscn")
