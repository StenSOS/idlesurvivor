extends Node2D

@onready var health_bar = $healthBar
@onready var enemy_holder = $"../enemyHolder"

@export var maxHealth : int 
@export var health: int
@export var playerDamage :int 
@export var attack_cooldown : float 
var current_attack_timer : float = 0.0
var isDead : bool = false

func _ready():
	health_bar.max_value= maxHealth
	health_bar.value = health
	maxHealth = GameData.playerMaxHealth
	health = maxHealth
	playerDamage = GameData.playerDamage
	attack_cooldown = GameData.playerAttackSpeed

func  _process(delta):
	if not isDead:
		current_attack_timer += delta
		# Sayaç dolduysa saldır ve sayacı sıfırla
		if current_attack_timer >= attack_cooldown:
			attack_nearest_enemy()
			current_attack_timer = 0.0

func updateHealthUI():
	health_bar.max_value= maxHealth
	health_bar.value = health

func attack_nearest_enemy():
	var enemies = get_tree().get_nodes_in_group("enemy")
	var nearest_enemy = null
	var min_dist = INF
	
	for enemy in enemies:
		var dist = global_position.distance_to(enemy.global_position)
		if dist < min_dist and dist < 400: # 400 menzil
			min_dist = dist
			nearest_enemy = enemy
			
	if nearest_enemy:
		nearest_enemy.takeDamage(playerDamage)
		print("Düşmana vuruldu!")
		print(GameData.playerDamage)

func takeDamage(damageAmount : int):
	health -= damageAmount
	updateHealthUI()
	gameOver()

func gameOver():
	if health <= 0:
		isDead=true
		print("dead")
		get_tree().change_scene_to_file("res://mainMenu/main_menu.tscn")
