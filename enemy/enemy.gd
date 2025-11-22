extends CharacterBody2D

@export var speed: float = 100.0
@export var damage: int = 5
@export var attack_distance: float = 175
@export var attack_rate: float = 1.0   # saniyede bir vur
@export var maxHp := 10
@export var currentHp := maxHp

@onready var attack_cooldown_timer = $attackCooldownTimer

var player : Node2D

func _ready():	
	player = get_tree().get_first_node_in_group("player")
	attack_cooldown_timer.wait_time = attack_rate
	attack_cooldown_timer.start()

func _physics_process(delta):
	if not player: 
		return
	
	var dir : Vector2 = (player.global_position - global_position).normalized()
	if global_position.distance_to(player.global_position) > attack_distance:
		velocity = dir * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO

func _on_attack_cooldown_timer_timeout():
	if not player: 
		return
	
	if global_position.distance_to(player.global_position) <= attack_distance:
		player.takeDamage(damage)
