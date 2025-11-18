extends Node2D

@onready var health_bar = $healthBar

@export var maxHealth : int = 100
@export var health := maxHealth

func  _process(delta):
	health_bar.max_value= maxHealth
	health_bar.value = health
