extends Node2D

@onready var health_bar = $healthBar

@export var maxHealth : int = 100
@export var health := maxHealth

var isDead : bool = false

func  _process(delta):
	health_bar.max_value= maxHealth
	health_bar.value = health
	


func takeDamage(damageAmount : int):
	health -= damageAmount
	gameOver()

func gameOver():
	if health <= 0:
		isDead=true
		print("dead")
